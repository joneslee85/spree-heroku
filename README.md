Spree Heroku
============

This is an extension for Spree, allowing the e-commerce system to run on Heroku - http://heroku.com.

The major constraint on Heroku is that we can't write files to disk, so this extension disables all disk caching, fixes a few issues and changes Spree to store on Amazon S3.

Requirements
------------

A Heroku account and an Amazon S3 account with a bucket.

Installation and configuration
-------------------------------

Add this to your project Gemfile:

    gem 'spree_heroku', :git => 'git://github.com/joneslee85/spree-heroku.git'

Install the new gems with bundler:

    $ bundle install

Specify the S3 credentials by two ways:

Create Heroku config var for specific environment
    
    $ heroku config:add S3_KEY='your_access_key'
    $ heroku config:add S3_SECRET='secret_access_key'
    $ heroku config:add S3_BUCKET='your_app_bucket'

OR

Create under RAILS_ROOT/config/s3.yml

    development:
      bucket: your_app_dev
      access_key_id: your_access_key
      secret_access_key: secret_access_key
      url: domain_url_or_path

    test:
      bucket: your_app_test
      access_key_id: your_access_key
      secret_access_key: secret_access_key
      url: domain_url_or_path

    production:
      bucket: your_app_prod
      access_key_id: your_access_key
      secret_access_key: secret_access_key
      url: domain_url_or_path


Create a Heroku application and deploy it:

    $ git init
    $ git add .
    $ git commit -m 'Initial create'
    $ heroku create
    $ git push heroku master

Bootstrap the database locally (not possible in Heroku, because the rake task attempts to copy files), and transfer it to Heroku:

    $ bundle exec rake db:bootstrap
    $ heroku db:push

Please note that if you choose to load sample data, images will be missing for all products. Spree's bootstrap task copies the images locally, but it doesn't put them on S3, where this extension configures Spree to look for images.

That's it - you're done! :)

Explanation about url variable
------------------------------

See the url variable in http://rdoc.info:8080/github/thoughtbot/paperclip/master/Paperclip/Storage/S3.

_url_ in s3.yml can be ":s3_domain_url" or ":s3_path_url" (default). STRING.


Troubleshooting
---------------

This extension has been tested with Spree 1.0 and Rails 3.1.3. If you have problems using the extension with a newer version of Spree, it could be due to Spree's gem dependencies having changed.

Copyright (c) 2012 Trung Lê, released under the New BSD License
