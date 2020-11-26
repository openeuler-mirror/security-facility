# appraise
# Copyright (c), 2020-2020, Huawei Tech. Co., Ltd.
# Author: Zhang Tianxing <zhangtianxing3@huawei.com>

name := appraise

top_srcdir		?= ../../../..

include $(top_srcdir)/include/mk/testcases.mk

INSTALL_TARGETS         += test_enforce_attr.sh
INSTALL_TARGETS         += test_enforce_access.sh
INSTALL_TARGETS         += test_enforce_digest.sh
INSTALL_TARGETS         += test_log_attr.sh
INSTALL_TARGETS         += test_log_access.sh
INSTALL_TARGETS         += test_log_digest.sh

include $(top_srcdir)/include/mk/generic_leaf_target.mk
