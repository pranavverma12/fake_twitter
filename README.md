# Flow of the Project

### 1. Database: SQLite

### 2. Editor: Sublime Text

### 3. OS: Windows

### 4. Installation of the project:
1. `rails 6.0.2.1`
1. `ruby 2.5.7p206 (2019-10-01 revision 67816) [x64-mingw32]` 
1. Clone this project
1. `bundle install` - install gems
1. `bundle exec rake db:create` - set up sqlite database
1. `bundle exec rake db:schema:load` - load the database schema into development database (if required)
1. `rails db:seed` - populate database with some test data (running this deletes any existing data)
1. `RAILS_ENV=test rake db:schema:load` - load the database schema in test database
1. This project has contains testing to run test cases use `rspec` or `bundle exec rspec`
1. Rails 6 is packaged with webpacker, so we need to install and run `yarn` before we can start a rails server.

### 5. Project Description
This project is the an attempt to build a lookalike of a Twitter.

I have chosen `sqlite` as the database to keep the project easy to run (to deploy on heroku it has been changed to pg)

If you wish to change to a different database solution or use any other external services to see the tasks ... please feel free to do so.

### 6. Getting Started

The commands to set up the rails project are pretty much the same for any rails 6 project:
1. `bundle install` - install gems
1. `bundle exec rake db:create` - set up sqlite database
1. `bundle exec rake db:schema:load` - load the database schema into development database
1. `RAILS_ENV=test rake db:schema:load` - load the database schema in test database
1. `bundle exec rake db:seed` - populate database with some test data (running this deletes any existing data)
1. `bundle exec rspec` - run all the tests, so you can get an idea of what is already present in project. (Also early indicator of problems if any of the tests fail. They should all pass at this beginning stage, 216 tests)
1. Rails 6 is packaged with webpacker, so we need to install and run `yarn` before we can start a rails server.

Lastly, start rails server and login with default user:
* `bundle exec rails s`


### 7. Initial Project
This project is a database of user, posts and relationship.

The initial project contains the following data models (including model unit tests):
* User 
  * username
  * email
  * password (using bcrypt-ruby & ActiveModel::SecurePassword)

* Post
  * description
  * photo
  * user_id

* Relationship
  * follower_id
  * followed_id

The current features are provided (including controller tests):
* User can 
	1. Register an account (email/password) 
	2. Session creation(login)
	3. Session destroy(logout)
	4. Change Password from the inside the account.
	5. See how many followers it has
	6. How many are following him/her
	7. Search a user by its username or email
	8. See profile page of other's.
	`Note:` If user A is not following user B which has posts than posts will not be visible to user A. Once user A start following user B, posts will be visible.

* Posts can be 
	1. Created by user who is logged in
	2. Edit its own posts 
	3. Delete its own posts
	4. See posts of it's own as well as user whom he/she is following.

* Relationship will store the records of who is following whom.
