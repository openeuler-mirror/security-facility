#!/bin/bash
# Copyright (c), 2020-2020, Huawei Tech. Co., Ltd.
# Description: test_log_attr
# Author: Zhang Tianxing <zhangtianxing3@huawei.com>
# Create: 2020/09/08

TST_TESTFUNC=test_log_attr
TST_SETUP=setup

export TCID=test_log_attr

. tst_test.sh

TESTFILE=/usr/bin/echo

setup() {
    if ! cat /proc/cmdline | grep "ima_appraise=log"; then
        tst_brk TCONF "[$TCID] Required cmdline ima_appraise=log."
        return
    fi
}

cleanup() {
    upload_digest_lists -p add-ima-xattr -d /etc/ima/digest_lists.tlv > /dev/null 2>&1
    upload_digest_lists -p add-evm-xattr -d /etc/ima/digest_lists.tlv > /dev/null 2>&1
    chmod 755 $TESTFILE
    chown root $TESTFILE
    chgrp root $TESTFILE
    chcon system_u:object_r:bin_t:s0 $TESTFILE
}

test_log_delete_ima_xattr() {
    setfattr -x security.ima $TESTFILE > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        tst_res TFAIL "[$TCID] test for deleting security.ima failed."
    else
        tst_res TPASS "[$TCID] test for deleting security.ima success."
    fi
}

test_log_delete_evm_xattr() {
    setfattr -x security.evm $TESTFILE > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        tst_res TFAIL "[$TCID] test for deleting security.evm failed."
    else
        tst_res TPASS "[$TCID] test for deleting security.evm success."
    fi
}

test_log_delete_selinux_xattr() {
    setfattr -x security.selinux $TESTFILE > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        tst_res TFAIL "[$TCID] test for deleting security.selinux failed."
    else
        tst_res TPASS "[$TCID] test for deleting security.selinux success."
    fi
}

test_log_set_ima_xattr() {
    setfattr -n security.ima -v "0x04040205" $TESTFILE > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        tst_res TFAIL "[$TCID] test for setting security.ima failed."
    else
        tst_res TPASS "[$TCID] test for setting security.ima success."
    fi
}

test_log_set_evm_xattr() {
    setfattr -n security.evm -v "0x04040205" $TESTFILE > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        tst_res TFAIL "[$TCID] test for setting security.evm failed."
    else
        tst_res TPASS "[$TCID] test for setting security.evm success."
    fi
}

test_log_set_selinux_xattr() {
    chcon -t etc_t $TESTFILE > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        tst_res TFAIL "[$TCID] test for setting security.selinux failed."
    else
        tst_res TPASS "[$TCID] test for setting security.selinux success."
    fi
}

test_log_set_file_permission() {
    chmod 777 $TESTFILE > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        tst_res TFAIL "[$TCID] test for setting permission failed."
    else
        tst_res TPASS "[$TCID] test for setting permission success."
    fi
}

test_log_set_uid() {
    adduser ima_test

    chown ima_test $TESTFILE > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        tst_res TFAIL "[$TCID] test for UID setting failed."
        chown root $TESTFILE
    else
        tst_res TPASS "[$TCID] test for UID setting success."
    fi

    userdel -r ima_test
}

test_log_set_gid() {
    adduser ima_test

    chgrp ima_test $TESTFILE > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        tst_res TFAIL "[$TCID] test for GID setting failed."
        chgrp root $TESTFILE
    else
        tst_res TPASS "[$TCID] test for GID setting success."
    fi

    userdel -r ima_test
}

test_log_attr() {
    test_log_delete_ima_xattr
    test_log_delete_evm_xattr
    test_log_delete_selinux_xattr
    test_log_set_ima_xattr
    test_log_set_evm_xattr
    test_log_set_selinux_xattr
    test_log_set_file_permission
    test_log_set_uid
    test_log_set_gid
    cleanup
}

tst_run
