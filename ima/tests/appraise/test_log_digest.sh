#!/bin/bash
# Copyright (c), 2020-2020, Huawei Tech. Co., Ltd.
# Description: test_log_digest
# Author: Zhang Tianxing <zhangtianxing3@huawei.com>
# Create: 2020/09/11

TST_TESTFUNC=test_log_digest
TST_SETUP=setup

export TCID=test_log_digest

. tst_test.sh

TEST_DATA_DIR=/opt/ltp/testcases/data/ima_digest_lists
TEST_DIGEST_LIST_PATH=$TEST_DATA_DIR/tree-digest-list
TEST_DIGEST_LIST_SIG_PATH=$TEST_DATA_DIR/tree-digest-list.sig

SECURITYFS=/sys/kernel/security
DIGEST_LIST_ADD_PATH=$SECURITYFS/ima/digest_list_data
DIGEST_LIST_DEL_PATH=$SECURITYFS/ima/digest_list_data_del
DIGEST_LIST_COUNT=$SECURITYFS/ima/digests_count

setup() {
    if ! cat /proc/cmdline | grep "ima_appraise=log"; then
        tst_brk TCONF "[$TCID] Required cmdline ima_appraise=log."
        return
    else
        setfattr -n security.ima -v "0x0404$(sha256sum $TEST_DIGEST_LIST_PATH | awk '{print $1}')" $TEST_DIGEST_LIST_PATH
        setfattr -n security.evm -v "0x$(xxd -p -c 1000 $TEST_DIGEST_LIST_SIG_PATH)" $TEST_DIGEST_LIST_PATH
        chcon system_u:object_r:etc_t:s0 $TEST_DIGEST_LIST_PATH
        chmod 600 $TEST_DIGEST_LIST_PATH
    fi
}

test_log_delete_digest_list() {
    echo $TEST_DIGEST_LIST_PATH > $DIGEST_LIST_DEL_PATH
    if [ $? -ne 0 ]; then
        tst_res TFAIL "[$TCID] can't delete digest list manually."
    else
        tst_res TPASS "[$TCID] test for deleting digest list success."
    fi
}

test_log_import_digest_list() {
    echo $TEST_DIGEST_LIST_PATH > $DIGEST_LIST_ADD_PATH
    if [ $? -ne 0 ]; then
        tst_res TFAIL "[$TCID] can't import digest list manually."
    else
        tst_res TPASS "[$TCID] test for importing digest list success."
    fi
}

test_log_digest() {
    test_log_delete_digest_list
    test_log_import_digest_list
}

tst_run
