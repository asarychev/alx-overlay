# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="User for net-misc/vlmcsd"
ACCT_USER_ID=526
ACCT_USER_GROUPS=( vlmcsd )

acct-user_add_deps
