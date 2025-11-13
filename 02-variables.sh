#!/bin/bash

project_name="roboshop"
environment=dev

component1=$1
component2=$2

echo "Project name is :: ${project_name}"
echo "environment is :: $environment"

echo "component 1 :: $component1"
echo "component 2 :: $component2"
# sh file2.sh catalogue frontend 

echo "Enter Email Id"
read email
echo "Your mail is $email"

echo "Enter Password"
read -s password
echo "Your password is $password"

export name="phani"
echo "My Name is :: $name"