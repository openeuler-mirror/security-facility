#!/bin/bash
# Copyright (c), 2020-2020, Huawei Tech. Co., Ltd.
# Description: test_log_access
# Author: Zhang Tianxing <zhangtianxing3@huawei.com>
# Create: 2020/09/09

TST_TESTFUNC=test_log_access
TST_SETUP=setup

export TCID=test_log_access

. tst_test.sh

TESTFILE=/usr/bin/ls
TESTFILE_BAK=$TESTFILE"_bak"
TESTFILE_LN_TEST=$TESTFILE"_ln_test"

setup() {
    if ! cat /proc/cmdline | grep "ima_appraise=log"; then
        tst_brk TCONF "[$TCID] Required cmdline ima_appraise=log."
        return
    fi
}

test_log_access_nochanges() {
    $TESTFILE > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        tst_res TFAIL "[$TCID] test for no changed file accessing failed."
    else
        tst_res TPASS "[$TCID] test for no changed file accessing success."
    fi
}

test_log_access_copyfile_without_xattr() {
    cp $TESTFILE $TESTFILE_BAK

    $TESTFILE_BAK > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        tst_res TFAIL "[$TCID] test for new file accessing failed."
    else
        tst_res TPASS "[$TCID] test for new file accessing success."
    fi

    rm $TESTFILE_BAK
}

test_log_access_copyfile_with_xattr() {
    cp -a $TESTFILE $TESTFILE_BAK

    $TESTFILE_BAK > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        tst_res TFAIL "[$TCID] test for new file accessing failed."
    else
        tst_res TPASS "[$TCID] test for new file accessing success."
    fi

    rm $TESTFILE_BAK
}

test_log_access_context_changed() {
    cp -a $TESTFILE $TESTFILE_BAK
    echo "test_pad" >> $TESTFILE

    $TESTFILE > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        tst_res TFAIL "[$TCID] test for modified file accessing failed."
    else
        tst_res TPASS "[$TCID] test for modified file accessing success."
    fi

    rm $TESTFILE
    mv $TESTFILE_BAK $TESTFILE
}

test_log_access_attr_restore() {
    cp $TESTFILE $TESTFILE_BAK
    rm $TESTFILE
    mv $TESTFILE_BAK $TESTFILE

    $TESTFILE > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        tst_res TFAIL "[$TCID] test for attr restored accessing failed."
    else
        tst_res TPASS "[$TCID] test for attr restored accessing success."
    fi

    upload_digest_lists -p add-ima-xattr -d /etc/ima/digest_lists.tlv > /dev/null 2>&1
    upload_digest_lists -p add-evm-xattr -d /etc/ima/digest_lists.tlv > /dev/null 2>&1
    chmod 755 $TESTFILE
    chcon -u system_u $TESTFILE
}

test_log_access_uid_changed() {
    cp $TESTFILE $TESTFILE_BAK
    rm $TESTFILE
    mv $TESTFILE_BAK $TESTFILE

    adduser ima_test
    chown ima_test $TESTFILE
    if [ $? -ne 0 ]; then
        tst_res TFAIL "[$TCID] test for changing UID failed."
    fi

    upload_digest_lists -p add-ima-xattr -d /etc/ima/digest_lists.tlv > /dev/null 2>&1
    upload_digest_lists -p add-evm-xattr -d /etc/ima/digest_lists.tlv > /dev/null 2>&1
    chmod 755 $TESTFILE
    chcon -u system_u $TESTFILE

    $TESTFILE > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        tst_res TFAIL "[$TCID] test for UID modified accessing failed."
    else
        tst_res TPASS "[$TCID] test for UID modified accessing success."
    fi

    chown root $TESTFILE
    userdel -r ima_test
}

test_log_access_gid_changed() {
    cp $TESTFILE $TESTFILE_BAK
    rm $TESTFILE
    mv $TESTFILE_BAK $TESTFILE

    adduser ima_test
    chgrp ima_test $TESTFILE
    if [ $? -ne 0 ]; then
        tst_res TFAIL "[$TCID] test for changing GROUP failed."
    fi

    upload_digest_lists -p add-ima-xattr -d /etc/ima/digest_lists.tlv > /dev/null 2>&1
    upload_digest_lists -p add-evm-xattr -d /etc/ima/digest_lists.tlv > /dev/null 2>&1
    chmod 755 $TESTFILE
    chcon -u system_u $TESTFILE

    $TESTFILE > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        tst_res TFAIL "[$TCID] test for GID modified accessing failed."
    else
        tst_res TPASS "[$TCID] test for GID modified accessing success."
    fi

    chgrp root $TESTFILE
    userdel -r ima_test
}

test_log_access_mod_changed() {
    cp $TESTFILE $TESTFILE_BAK
    rm $TESTFILE
    mv $TESTFILE_BAK $TESTFILE

    chmod 777 $TESTFILE
    if [ $? -ne 0 ]; then
        tst_res TFAIL "[$TCID] test for changing MODE failed."
    fi

    upload_digest_lists -p add-ima-xattr -d /etc/ima/digest_lists.tlv > /dev/null 2>&1
    upload_digest_lists -p add-evm-xattr -d /etc/ima/digest_lists.tlv > /dev/null 2>&1
    chcon -u system_u $TESTFILE

    $TESTFILE > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        tst_res TFAIL "[$TCID] test for MODE modified accessing failed."
    else
        tst_res TPASS "[$TCID] test for MODE modified accessing success."
    fi

    chmod 755 $TESTFILE
}

test_log_access_selinux_changed() {
    cp $TESTFILE $TESTFILE_BAK
    rm $TESTFILE
    mv $TESTFILE_BAK $TESTFILE

    chcon -t admin_home_t $TESTFILE
    if [ $? -ne 0 ]; then
        tst_res TFAIL "[$TCID] test for changing SELinux failed."
    fi

    upload_digest_lists -p add-ima-xattr -d /etc/ima/digest_lists.tlv > /dev/null 2>&1
    upload_digest_lists -p add-evm-xattr -d /etc/ima/digest_lists.tlv > /dev/null 2>&1
    chcon -u system_u $TESTFILE
    chmod 755 $TESTFILE

    $TESTFILE > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        tst_res TFAIL "[$TCID] test for SELinux modified accessing failed."
    else
        tst_res TPASS "[$TCID] test for SELinux modified accessing success."
    fi

    chcon -t bin_t $TESTFILE
}

test_log_access_ln_nochanges() {
    ln -s $TESTFILE $TESTFILE_LN_TEST

    $TESTFILE_LN_TEST > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        tst_res TFAIL "[$TCID] test for link file failed."
    else
        tst_res TPASS "[$TCID] test for link file success."
    fi

    rm $TESTFILE_LN_TEST
}

test_log_access_ln_changed() {
    cp -a $TESTFILE $TESTFILE_BAK

    echo "ima_test" >> $TESTFILE
    ln -s $TESTFILE $TESTFILE_LN_TEST

    $TESTFILE_LN_TEST > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        tst_res TFAIL "[$TCID] test for modified link file failed."
    else
        tst_res TPASS "[$TCID] test for modified link file success."
    fi

    rm $TESTFILE_LN_TEST
    rm $TESTFILE
    mv $TESTFILE_BAK $TESTFILE
}

test_log_access() {
    test_log_access_nochanges
    test_log_access_newfile
    test_log_access_context_changed
    test_log_access_attr_restore
    test_log_access_uid_changed
    test_log_access_gid_changed
    test_log_access_mod_changed
    test_log_access_selinux_changed
    test_log_access_ln_nochanges
    test_log_access_ln_changed
}

tst_run
