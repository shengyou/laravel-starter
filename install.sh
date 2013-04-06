#!/bin/bash

###
# config
###
# get project name from input
read -p "Please enter your porject name: (src)" project_name
project_name=${project_name:-src}


###
# check enviroments
###
echo "Checking your enviroments..."
os=$(uname)
curl=$(which curl)
composer=$(which composer)
unzip=$(which unzip)
git=$(which git)

if [[ ! -e $curl ]] ; then
    echo "Curl is not found, please install curl first"
    break
elif [[ ! -e $unzip ]] ; then
    echo "Unzip is not found, please install unzip first"
    break
elif [[ ! -e $composer ]] ; then
    echo "Composer is not found, please install composer first"
    echo "More information could be found at http://getcomposer.org/"
    break
elif [[ ! -e $git ]] ; then
	echo "Git is not found, please install git first"
    break
else
	echo "Great! your enviroments is checked, start to donwload laravel..."
fi


###
# get laravel
###
# download laravel
curl -L -O https://github.com/laravel/laravel/archive/develop.zip 
# wget https://github.com/laravel/laravel/archive/develop.zip

# unzip zip file
unzip develop.zip


###
# Install dependencies
###
echo "Installing dependencies..."

# install composer packages
mv laravel-develop $project_name
cd ${PWD}/$project_name
composer install


###
# Laravel configuration
###
echo "Installing dependencies..."

# config timezone

# config locale

# generate key
php artisan key:generate

# setup permission
chmod -R 777 app/storage

###
# Done and Clean up
###
echo "Great! everthing is done, ready to start server..."

# clean up
rm -rf ../develop.zip
rm install.sh
rm README.md
git init
git add .
git commit -m "first commit: project init"

# open safari to show hello world
if [[ $os == "Darwin" ]] ; then
	open -a Safari http://localhost:8000
fi

# start laravel server
php artisan serve
