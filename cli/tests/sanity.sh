#!/bin/bash - 
PREFIX=$1
. $PREFIX/cli/kalcliAutoComplete
. $PREFIX/cli/kalcliAliases.sh
echo "######### Running tests ###########"
kalcli -x media list ks=`genks -b $PARTNER_ID`
kalcli -x baseentry list ks=`genks -b $PARTNER_ID`
