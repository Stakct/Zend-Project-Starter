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

  #Check if zftool.phar exists and then update before to go.
  if [ ! -f vendor/bin/zf.php ]
  then
    php composer.phar require zendframework/zftool:dev-master
  fi

  if [ ! -f zftool.phar ]
  then
    wget http://packages.zendframework.com/zftool.phar
  fi

  cp zps.sh test/zps.sh

  echo "Well done! - Everything is installed and up-to-date, go to public/ and execute php -S localhost:8888 to test your project.\nYou can now use zps.sh inside your project folder.";
elif [ $1 = "module-list" ]
then
  php zftool.phar modules
else
  echo "Welcome to Zend Project Starter v0.1\n
I'm here to help you to create a zen project with composer!\n
\n
Create project - Usage: sh zps.sh create DIRNAME\n
\n
Module list - Usage(inside project folder): sh zps.sh module-list\n
\n
Have fun! - Salvatore Tarda";
fi
