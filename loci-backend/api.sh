#!/bin/bash
# Use user:user for login to check user login with keycloak
# Make sure check user is verified and temporary password is off
# READ docs; https://documenter.getpostman.com/view/7294517/SzmfZHnd

TOKEN_RESPONSE=$(curl --location 'http://localhost:9090/realms/loci-realm/protocol/openid-connect/token' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--data-urlencode 'client_id=spring' \
--data-urlencode 'username=testuser1@gmail.com' \
--data-urlencode 'password=example1' \
--data-urlencode 'grant_type=password')

# --data-urlencode 'username=user' \
# --data-urlencode 'password=user' \

printf '\n\n\n'
echo $TOKEN_RESPONSE


AUTHORIZATION=$(echo $TOKEN_RESPONSE | jq .access_token -r)


printf '\n\n\n'
echo $AUTHORIZATION

echo  $AUTHORIZATION | xclip -selection c
