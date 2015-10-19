

Local Installation
------------------

1. Download and install railsinstaller (git is included)--> www.railsinstaller.org

2. Clone the repository

  `git clone https://github.com/papayalabs/react-rails-development.git´

3. Configure your database in config/database.yml The current config assumes a custom local SQLite configuration.

   `edit config/database.yml`

4. Install gems

  `bundle`

5. Migrate database

  `rake db:migrate`

6. Start your webserver

  `rails s`

Using Heroku
------------------

In order to use heroku, you need to:

  1. Download and install the heroku toolbelt for windows at https://toolbelt.heroku.com/

  2. Log in using the email address and password you used when creating your Heroku account

  3. Create an application

	`heroku create`

  4. Deploy the application
 	
	`git push heroku master ( if you get Permission denied (publickey) --> heroku keys:add )`

  5. Migrate database

	`heroku run rake db:migrate`

Additionally, we’ll need to the set the AWS configuration variables on the Heroku application to use paperclip:

	`$ heroku config:set S3_BUCKET_NAME=your_bucket_name`
	`$ heroku config:set AWS_ACCESS_KEY_ID=your_access_key_id`
	`$ heroku config:set AWS_SECRET_ACCESS_KEY=your_secret_access_key`


