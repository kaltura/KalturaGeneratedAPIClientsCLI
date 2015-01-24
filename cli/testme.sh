#!/bin/bash -e
cd `dirname $0`
PREFIX=/opt/kaltura1
mkdir -p $PREFIX
cp -r . $PREFIX/cli
cd $PREFIX/cli
sed -i "s#@BASEDIR@#$PREFIX/cli#g" kalcliAliases.sh kalcliAutoComplete logToCli
shopt -s expand_aliases
ln -sf $PREFIX/cli/kalcliAutoComplete /etc/bash_completion.d/
. /etc/bash_completion.d/kalcliAutoComplete 
ln -sf $PREFIX/cli/kalcliAliases.sh /etc/profile.d/
. /etc/profile.d/kalcliAliases.sh
echo "[general]
ipSalt = @APP_REMOTE_ADDR_HEADER_SALT@
apiHost = 54.159.220.35
logDir = $PREFIX/log
[presetRepository]
class = KalturaPresetSecretRepository
101 = 0567e52a030ebc2ccb73b386aa1800e0" > $PREFIX/cli/config/config.ini
kalcli -x media list ks=`genks -b 101`
kalcli -x baseentry list ks=`genks -b 101`
