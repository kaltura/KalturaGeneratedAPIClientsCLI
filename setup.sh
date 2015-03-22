#!/bin/bash -e
if [ $# -lt 4 ];then
    echo "Usage: $1 </path/to/target/dir> <api_hostname> <partner_id> <partner_admin_secret>"
    exit 1
fi

cd `dirname $0`
PREFIX=$1
API_HOST=$2
PARTNER_ID=$3
ADMIN_SECRET=$4
mkdir -p $PREFIX
cp -r . $PREFIX
cd $PREFIX
sed -i "s#@BASEDIR@#$PREFIX#g" kalcliAliases.sh kalcliAutoComplete logToCli
shopt -s expand_aliases
. $PREFIX/kalcliAutoComplete
. $PREFIX/kalcliAliases.sh

# if we are a super user, we can symlink aliases and bash completion.
if [ `id -u` = 0 ] ;then 
    ln -sf $PREFIX/kalcliAutoComplete /etc/bash_completion.d/
    ln -sf $PREFIX/kalcliAliases.sh /etc/profile.d/
fi
sed  -e "s#54.81.207.25#$API_HOST#g" -e "s#~/kaltura/log#$PREFIX/log#g" -e "s#101#$PARTNER_ID#g" -e "s#066439f83615896a16efce529b84fcfb#$ADMIN_SECRET#g" $PREFIX/config/config.template.ini > $PREFIX/config/config.ini
