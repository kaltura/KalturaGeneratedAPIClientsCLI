#!/bin/bash - 
if [ $# -lt 2 ];then
    echo "Usage: $1 </path/cli/lib/prefix> <partner_id>"
    exit 1
fi
PREFIX=$1
PARTNER_ID=$2
shopt -s expand_aliases
. $PREFIX/cli/kalcliAutoComplete
. $PREFIX/cli/kalcliAliases.sh
PASSED=0
FAILED=0
inc_counter()
{
    VAL=$1
    if [ $VAL -eq 0 ];then
	PASSED=`expr $PASSED + 1`
    else
	FAILED=`expr $FAILED + 1`
    fi
}
echo "######### Running tests ###########"
kalcli -x media list ks=`genks -b $PARTNER_ID`
inc_counter $?
kalcli -x baseentry list ks=`genks -b $PARTNER_ID`
inc_counter $?
echo "PASSED tests: $PASSED, FAILED tests: $FAILED"
