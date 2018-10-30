#!/bin/bash
 
#Set variables
username360="your@email.com"
password360="PASS"
mosquitto_pub="/path/to/mosquitto_pub"
mqtt_host="127.0.0.1"
mqtt_port="1883"
mqtt_user="USER"
mqtt_pass="PASS"
timeout=300
 
 
function bearer {
echo "$(date +%s) INFO: requesting access token"
bearer_id=$(curl -s -X POST -H "Authorization: Basic cFJFcXVnYWJSZXRyZTRFc3RldGhlcnVmcmVQdW1hbUV4dWNyRUh1YzptM2ZydXBSZXRSZXN3ZXJFQ2hBUHJFOTZxYWtFZHI0Vg==" -F "grant_type=password" -F "username=$username360" -F "password=$password360" https://api.life360.com/v3/oauth2/token.json | grep -Po '(?<="access_token":")\w*')
}
 
function circles () {
echo "$(date +%s) INFO: requesting circles."
read -a circles_id <<<$(curl -s -X GET -H "Authorization: Bearer $1" https://api.life360.com/v3/circles.json | grep -Po '(?<="id":")[\w-]*')
}
 
function members () {
members=$(curl -s -X GET -H "Authorization: Bearer $1" https://api.life360.com/v3/circles/$2)
echo "$(date +%s) INFO: requesting members"
}
 
bearer
circles $bearer_id
 
#Main Loop
while :
do
 
#Check if circle id is valid. If not request new token.
if [ -z "$circles_id" ]; then
bearer
circles $bearer_id
fi
 
#Loop through circle ids
for i in "${circles_id[@]}"
do
 
#request member list
members $bearer_id $i
 
#Check if member array is valid. If not request new token
if [ -z "$members" ]; then
bearer
circles $bearer_id
members $bearer_id $i
fi
 
members_id=$(echo $members | jq '.members[].id')
IFS=$'\n' read -rd '' -a members_array <<<"$members_id"
count=0
for i in "${members_array[@]}"
do
    firstName=$(echo $members | jq .members[$count].firstName)
    lastName=$(echo $members | jq .members[$count].lastName)
    latitude=$(echo $members | jq .members[$count].location.latitude)
    longitude=$(echo $members | jq .members[$count].location.longitude)
    accuracy=$(echo $members | jq .members[$count].location.accuracy)
    battery=$(echo $members | jq .members[$count].location.battery)
    $mosquitto_pub -h $mqtt_host -p $mqtt_port -u $mqtt_user -P $mqtt_pass -t "owntracks/${firstName//\"/}/${i//\"/}" -m "{\"t\":\"p\",\"tst\":$(date +%s),\"acc\":${accuracy//\"/},\"_type\":\"location\",\"alt\":0,\"lon\":${longitude//\"/},\"lat\":${latitude//\"/},\"batt\": ${battery//\"/}}"
    count=$(($count+1))
done
done
sleep $timeout
done
