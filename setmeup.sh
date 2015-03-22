#!/bin/bash -e
if [ $# -lt 4 ];then
    echo "Usage: $1 </path/cli/lib/prefix> <api_hostname> <partner_id> <partner_admin_secret>"
    exit 1
fi

cd `dirname $0`
PREFIX=$1
API_HOST=$2
PARTNER_ID=$3
ADMIN_SECRET=$4
mkdir -p $PREFIX
cp -r . $PREFIX/cli
cd $PREFIX/cli
sed -i "s#@BASEDIR@#$PREFIX/cli#g" kalcliAliases.sh kalcliAutoComplete logToCli
shopt -s expand_aliases
. $PREFIX/cli/kalcliAutoComplete
. $PREFIX/cli/kalcliAliases.sh
if [ `id -u` = 0 ] ;then 
    ln -sf $PREFIX/cli/kalcliAutoComplete /etc/bash_completion.d/
    ln -sf $PREFIX/cli/kalcliAliases.sh /etc/profile.d/
fi
sed  -e "s#54.159.220.35#$API_HOST#g" -e "s#~/kaltura/log#$PREFIX/log#g" -e "s#101#$PARTNER_ID#g" -e "s#0567e52a030ebc2ccb73b386aa1800e0#$ADMIN_SECRET#g" $PREFIX/cli/config/config.template.ini > $PREFIX/cli/config/config.ini
cd -
