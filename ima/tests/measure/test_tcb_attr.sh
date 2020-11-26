#!/bin/bash
# Copyright (c), 2020-2020, Huawei Tech. Co., Ltd.
# Description: test_tcb_attr
# Author: Zhang Tianxing <zhangtianxing3@huawei.com>
# Create: 2020/09/08

TST_TESTFUNC=test_tcb_attr
TST_SETUP=setup

export TCID=test_tcb_attr

. tst_test.sh

TESTFILE=/usr/bin/echo

setup() {
    if  ! cat /proc/cmdline | grep "ima_policy=exec_tcb ima_digest_list_pcr=11"; then
        tst_brk TCONF "[$TCID] Required ima_appraise disabled."
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

test_tcb_delete_ima_xattr() {
    setfattr -x security.ima $TESTFILE > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        tst_res TFAIL "[$TCID] test for deleting security.ima failed."
    else
        tst_res TPASS "[$TCID] test for deleting security.ima success."
    fi
}

test_tcb_delete_evm_xattr() {
    setfattr -x security.evm $TESTFILE > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        tst_res TFAIL "[$TCID] test for deleting security.evm failed."
    else
        tst_res TPASS "[$TCID] test for deleting security.evm success."
    fi
}

test_tcb_delete_selinux_xattr() {
    setfattr -x security.selinux $TESTFILE > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        tst_res TFAIL "[$TCID] test for deleting security.selinux failed."
    else
        tst_res TPASS "[$TCID] test for deleting security.selinux success."
    fi
}

test_tcb_set_ima_xattr() {
    setfattr -n security.ima -v "0x04040205" $TESTFILE > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        tst_res TFAIL "[$TCID] test for setting security.ima failed."
    else
        tst_res TPASS "[$TCID] test for setting security.ima success."
    fi
}

test_tcb_set_evm_xattr() {
    setfattr -n security.evm -v "0x060402" $TESTFILE > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        tst_res TFAIL "[$TCID] test for setting security.evm failed."
    else
        tst_res TPASS "[$TCID] test for setting security.evm success."
    fi
}

test_tcb_set_selinux_xattr() {
    chcon -t etc_t $TESTFILE > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        tst_res TFAIL "[$TCID] test for setting security.selinux failed."
    else
        tst_res TPASS "[$TCID] test for setting security.selinux success."
    fi
}

test_tcb_set_file_permission() {
    chmod 777 $TESTFILE > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        tst_res TFAIL "[$TCID] test for setting permission failed."
    else
        tst_res TPASS "[$TCID] test for setting permission success."
    fi
}

test_tcb_set_uid() {
    adduser ima_test

    chown ima_test $TESTFILE > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        tst_res TFAIL "[$TCID] test for UID setting failed."
    else
        tst_res TPASS "[$TCID] test for UID setting success."
        chown root $TESTFILE
    fi

    userdel -r ima_test
}

test_tcb_set_gid() {
    adduser ima_test

    chgrp ima_test $TESTFILE > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        tst_res TFAIL "[$TCID] test for GID setting failed."
    else
        tst_res TPASS "[$TCID] test for GID setting success."
        chgrp root $TESTFILE
    fi

    userdel -r ima_test
}

test_tcb_attr() {
    test_tcb_delete_ima_xattr
    test_tcb_delete_evm_xattr
    test_tcb_delete_selinux_xattr
    test_tcb_set_ima_xattr
    test_tcb_set_evm_xattr
    test_tcb_set_selinux_xattr
    test_tcb_set_file_permission
    test_tcb_set_uid
    test_tcb_set_gid
    cleanup
}

tst_run
