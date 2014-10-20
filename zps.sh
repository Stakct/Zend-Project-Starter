#!/bin/bash

#Check if composer.phar exists and then update before to go.
if [ ! -f composer.phar ]
then
  php -r "readfile('https://getcomposer.org/installer');" | php
else
  php composer.phar self-update
fi

#Let's create a project
if [ $1 = "create" ]
then
  #check if directory exists
  if [ ! -d $2 ]
  then
    mkdir $2
  fi
  #let's create a project
  php composer.phar create-project -s dev --repository-url="http://packages.zendframework.com" zendframework/skeleton-application $2
  cd $2
  php composer.phar self-update
  php composer.phar install
  echo "Well done! - Everything is installed and up-to-date, go to public/ and execute php -S localhost:8888 to test your project.";
else
  echo "Welcome to Zend Project Starter v0.1\nI'm here to help you to create a zen project with composer!\n\nUsage: sh zps.sh create DIRNAME\n\nHave fun! - Salvatore Tarda";
fi
