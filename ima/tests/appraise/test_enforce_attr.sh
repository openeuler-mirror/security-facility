#!/bin/bash
# Copyright (c), 2020-2020, Huawei Tech. Co., Ltd.
# Description: test_enforce_attr
# Author: Zhang Tianxing <zhangtianxing3@huawei.com>
# Create: 2020/09/08

TST_TESTFUNC=test_enforce_attr
TST_SETUP=setup

export TCID=test_enforce_attr

. tst_test.sh

TESTFILE=/usr/bin/echo

setup() {
    if ! cat /proc/cmdline | grep "ima_appraise=enforce-evm"; then
        tst_brk TCONF "[$TCID] Required cmdline ima_appraise=enforce-evm."
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

test_enforce_delete_ima_xattr() {
    setfattr -x security.ima $TESTFILE > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        tst_res TFAIL "[$TCID] test for deleting security.ima failed."
    else
        tst_res TPASS "[$TCID] test for deleting security.ima success."
    fi
}

test_enforce_delete_evm_xattr() {
    setfattr -x security.evm $TESTFILE > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        tst_res TFAIL "[$TCID] test for deleting security.evm failed."
    else
        tst_res TPASS "[$TCID] test for deleting security.evm success."
    fi
}

test_enforce_delete_selinux_xattr() {
    setfattr -x security.selinux $TESTFILE > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        tst_res TFAIL "[$TCID] test for deleting security.selinux failed."
    else
        tst_res TPASS "[$TCID] test for deleting security.selinux success."
    fi
}

test_enforce_set_ima_xattr() {
    setfattr -n security.ima -v "0x04040205" $TESTFILE > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        tst_res TFAIL "[$TCID] test for setting security.ima failed."
    else
        tst_res TPASS "[$TCID] test for setting security.ima success."
    fi
}

test_enforce_set_evm_xattr() {
    setfattr -n security.evm -v "0x04040205" $TESTFILE > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        tst_res TFAIL "[$TCID] test for setting security.evm failed."
    else
        tst_res TPASS "[$TCID] test for setting security.evm success."
    fi
}

test_enforce_set_selinux_xattr() {
    chcon -t etc_t $TESTFILE > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        tst_res TFAIL "[$TCID] test for setting security.selinux failed."
    else
        tst_res TPASS "[$TCID] test for setting security.selinux success."
    fi
}

test_enforce_set_file_permission() {
    chmod 777 $TESTFILE > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        tst_res TFAIL "[$TCID] test for setting file permission failed."
    else
        tst_res TPASS "[$TCID] test for setting file permission success."
    fi
}

test_enforce_set_uid() {
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

test_enforce_set_gid() {
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

test_enforce_attr() {
    test_enforce_delete_ima_xattr
    test_enforce_delete_evm_xattr
    test_enforce_delete_selinux_xattr
    test_enforce_set_ima_xattr
    test_enforce_set_evm_xattr
    test_enforce_set_selinux_xattr
    test_enforce_set_file_permission
    test_enforce_set_uid
    test_enforce_set_gid
    cleanup
}

tst_run
