#!/bin/bash
TO_MAIL=$1
ALERT=$2
MESSAGE=$3

{
echo "To: $TO_MAIL"
echo "Subject: $ALERT"
# echo "Content-Type: text/html"
echo "Content-Type: text/plain"
echo ""
echo "$MESSAGE"
} | msmtp "$TO_MAIL"