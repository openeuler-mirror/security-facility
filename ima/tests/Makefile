# IMA test suite Makefile.
# Copyright (c), 2020-2020, Huawei Tech. Co., Ltd.
# Author: Zhang Tianxing <zhangtianxing3@huawei.com>

top_srcdir		?= ../../..

include $(top_srcdir)/include/mk/env_pre.mk

ifneq ($(UCLINUX),1)
# KEEP THIS LIST ALPHABETIZED PLEASE!
SUBDIRS				+= appraise
SUBDIRS				+= measure
SUBDIRS				+= datafiles
endif

include $(top_srcdir)/include/mk/generic_trunk_target.mk
