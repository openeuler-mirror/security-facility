#!/bin/bash
# Copyright (c), 2020-2020, Huawei Tech. Co., Ltd.
# Description: test_tcb_policy
# Author: Zhang Tianxing <zhangtianxing3@huawei.com>
# Create: 2020/09/15

TST_TESTFUNC=test_tcb_policy
TST_SETUP=setup

export TCID=test_tcb_policy

. tst_test.sh

setup() {
    if ! cat /proc/cmdline | grep "ima_policy=exec_tcb"; then
        tst_brk TCONF "[$TCID] Required cmdline ima_policy=exec_tcb."
        return
    fi
}

test_tcb_policy_mmap() {
    if ! cat /sys/kernel/security/ima/policy | grep "func=MMAP_CHECK mask=MAY_EXEC"; then
        tst_res TFAIL "[$TCID] mmap policy is not imported correctly."
    else
        tst_res TPASS "[$TCID] mmap policy is imported correctly."
    fi
}

test_tcb_policy_brpm() {
    if ! cat /sys/kernel/security/ima/policy | grep "func=BPRM_CHECK mask=MAY_EXEC"; then
        tst_res TFAIL "[$TCID] brpm policy is not imported correctly."
    else
        tst_res TPASS "[$TCID] brpm policy is imported correctly."
    fi
}

test_tcb_policy_module() {
    if ! cat /sys/kernel/security/ima/policy | grep "func=MODULE_CHECK"; then
        tst_res TFAIL "[$TCID] module policy is not imported correctly."
    else
        tst_res TPASS "[$TCID] module policy is imported correctly."
    fi
}

test_tcb_policy_firmware() {
    if ! cat /sys/kernel/security/ima/policy | grep "func=FIRMWARE_CHECK"; then
        tst_res TFAIL "[$TCID] firmware policy is not imported correctly."
    else
        tst_res TPASS "[$TCID] firmware policy is imported correctly."
    fi
}

test_tcb_policy_policy() {
    if ! cat /sys/kernel/security/ima/policy | grep "func=POLICY_CHECK"; then
        tst_res TFAIL "[$TCID] policy is not imported correctly."
    else
        tst_res TPASS "[$TCID] policy is imported correctly."
    fi
}

test_tcb_policy_digest() {
    if ! cat /sys/kernel/security/ima/policy | grep "func=DIGEST_LIST_CHECK"; then
        tst_res TFAIL "[$TCID] digest list policy is not imported correctly."
    else
        tst_res TPASS "[$TCID] digest list policy is imported correctly."
    fi
}

test_tcb_policy() {
    test_tcb_policy_mmap
    test_tcb_policy_brpm
    test_tcb_policy_module
    test_tcb_policy_firmware
    test_tcb_policy_policy
    test_tcb_policy_digest
}

tst_run
