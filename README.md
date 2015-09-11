FLVNT-web
=========

exclusive access to the unobtainable .


web application platform for [FLVNT](flvnt.com).  there are three main steps
for getting up and running, then developing:

* I. [environment setup](#i-environment-setup)
* II. [running the app](#ii-running-the-app)
* III. [ramping up](#iii-ramping-up)


-----


## I. environment setup

    $ git clone git@github.com:flvnt/FLVNT-web.git


### 1. setup python env + development tools (osx)

    $ sudo easy_install pip
    $ sudo pip install virtualenv virtualenvwrapper

    $ echo "export WORKON_HOME=\"${HOME}/.virtualenvs\"" >> ~/.bashrc
    $ echo ". /usr/local/bin/virtualenvwrapper.sh" >> ~/.bashrc
    $ echo "[ -s ~/.nvm/nvm.sh ] && . ~/.nvm/nvm.sh" >> ~/.bashrc
    $ echo "export PIP_VIRTUALENV_BASE=$" >> ~/.bashrc
    $ echo "nvm use 0.10.26" >> ~/.bashrc
    $ source ~/.bashrc

    $ mkvirtualenv flvnt-dev
    $ workon flvnt-dev
    $ pip install --upgrade pip
    $ pip install -r requirements.txt
    $ fab meteor_install  # installs: nvm, meteor.js


*note:* you may need to change paths to load fabctx. if you're getting
`from fab` to `ctx` errors, change to: `from fabctx` -> `from ctx`


### 2. setup + manage meteor packages

changes or updates to meteor packages need be flushed using meteorite.

to update the meteor packages through meteorite, run the command from the root
of the meteor project:

    $ nvm use 0.10.26
    $ cd ./app

*note:* this `mrt` call may fail, or will create the directory `./app/node_modules`.
try removing the directory: `./app/node_modules`.

    $ mrt


### 4. install phantomjs (osx)

    $ brew update && brew install phantomjs
    or
    $ sudo port selfupdate && sudo port install phantomjs
    or
    $ wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.7-macosx.zip


-----


## II. running the app

  # activate the node env
  $ nvm use 0.10.26

  # activate python virtualenv
  $ workon flvnt-dev


currently, the project uses fabric commands to help ensure speed and consistency
for repetitive tasks. the `$ fab meteor` and ` $ fab mongo` commands wrap the
normal command with specific connection settings for the development database.

    # run the meteor app
    $ fab meteor

    # connect to the mongodb shell
    $ fab mongo


## III. ramping up

    * inspect the packages in [app/.meteor/packages](app/.meteor/packages) and the [app/packages](app/packages) directory.
    * - also see the wiki: [wiki/09.-meteor-app-packages](https://github.com/flvnt/web/wiki/09.-meteor-app-packages)
    * [the aws pem key file [in the shared google-drive]](https://drive.google.com/#folders/0B8A4Eom0KFW7ek9RWjFLWHFaRTA)
    * [continue reading about the aws dns mappings](https://github.com/flvnt/flvnt-splash/wiki/aws-deployment)
    * [continue reading about the deployment notes](https://github.com/flvnt/flvnt-splash/wiki/aws-dns-mapping)



## IV. other notes

#### mongodb command-line: remove all collections

    db.getCollectionNames().forEach(function(c) {
        if(c != 'system.indexes' && c != 'system.users') {
            db.getCollection(c).drop();
        }
    });


-----


ubuntu/aws machine setup


## I. environment setup


### 1. setup python env + development tools

    $ sudo apt-get install python-pip python-dev
    $ mkvirtualenv flvnt-dev
    $ workon flvnt-dev
    $ pip install -r requirements.txt


### 4. install phantomjs (ubuntu)


    cd /usr/local/share
    sudo wget https://phantomjs.googlecode.com/files/phantomjs-1.9.0-linux-x86_64.tar.bz2
    sudo tar xjf phantomjs-1.9.0-linux-x86_64.tar.bz2
    sudo ln -s /usr/local/share/phantomjs-1.9.0-linux-x86_64/bin/phantomjs/usr/local/share/phantomjs
    sudo ln -s /usr/local/share/phantomjs-1.9.0-linux-x86_64/bin/phantomjs/usr/local/bin/phantomjs
    sudo ln -s /usr/local/share/phantomjs-1.9.0-linux-x86_64/bin/phantomjs/usr/bin/phantomjs
    phantomjs --version

