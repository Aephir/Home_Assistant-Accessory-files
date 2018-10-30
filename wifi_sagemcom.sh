#!/bin/bash
# Sagemcom Fast 3890 script for enabling/disabling Wifi 

user="admin"
password="somePassword"
ssid="MySSID"

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    off)
    DEFAULT_ON=0
    shift # past argument
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

if [ "$DEFAULT_ON" != 0 ] ; then
    DEFAULT_ON=1 
fi

auth=`echo -n $user':'$password | openssl base64`

rawSession="$(curl -vs 'http://'$user':'$password'@192.168.1.1/wlswitchinterface0.wl' 2>&1)"

sessionKey=`echo "$rawSession" | grep sessionKey | awk '{split($0, a, "="); print substr(a[3],1,length(a[3])-2)}'`

url='http://'$user':'$password'@192.168.1.1/wlcfg.wl?wlSsidIdx=0&wlEnbl='$DEFAULT_ON'&wlHide=0&wlAPIsolation=0&wlSsid='$ssid'&wlCountry=E0&wlMaxAssoc=50&wlDisableWme=0&wlNReqd=0&wlEnableWmf=0&wlEnbl_wl0v1=0&wlSsid_wl0v1=CableBox-E921_0_1&wlHide_wl0v1=0&wlAPIsolation_wl0v1=0&wlDisableWme_wl0v1=0&wlEnableWmf_wl0v1=0&wlMaxAssoc_wl0v1=50&wlNReqd_wl0v1=0&wlEnableGuestNetwork_wl0v1=0&wlEnbl_wl0v2=0&wlSsid_wl0v2=CableBox-E921_0_2&wlHide_wl0v2=0&wlAPIsolation_wl0v2=0&wlDisableWme_wl0v2=0&wlEnableWmf_wl0v2=0&wlMaxAssoc_wl0v2=50&wlNReqd_wl0v2=0&wlEnableGuestNetwork_wl0v2=0&wlEnbl_wl0v3=0&wlSsid_wl0v3=CableBox-E921_0_3&wlHide_wl0v3=0&wlAPIsolation_wl0v3=0&wlDisableWme_wl0v3=0&wlEnableWmf_wl0v3=0&wlMaxAssoc_wl0v3=50&wlNReqd_wl0v3=0&wlEnableGuestNetwork_wl0v3=0&wlSyncNvram=1&sessionKey='$sessionKey

curl -s $url -H 'Authorization: Basic '$auth > /dev/null
