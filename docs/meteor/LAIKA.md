laika test-runner
-----------------

* meteorjs `0.8.1.3
* laika `0.3.8`
* phantomjs `1.9.7`
* node `0.10.26`
* coffeescript `1.7.1`
* mocha `1.18.2`
* chai


## install node packages + dependencies

    $ npm install -g laika
    $ npm install -g coffee-script


## install phantomjs 1.9.7

    $ curl -L -O https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.7-macosx.zip
    $ tar -zxvf "phantomjs-1.9.7-macosx.zip"
    $ rm -rf "phantomjs-1.9.7-macosx.zip"
    $ ln -sf "$(pwd)/phantomjs-1.9.7-macosx/bin/phantomjs" "${NVM_BIN}"


## run the tests:

    $ cd .app/
    $ laika
