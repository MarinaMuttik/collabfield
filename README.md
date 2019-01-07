* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

# Collabfield

Web application to allow users to sign up and login, create and view posts assigned to branches with categories, and instant message other users.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

Requires Ruby version 2.5.1 and Postgres to be installed.

To install Ruby and RVM, use the steps outlined [here](https://github.com/rvm/ubuntu_rvm)
To install Postgres, use the steps outlined [here](http://postgresguide.com/setup/install.html). A database and environmental variables / login details will need to be set up to match / be modified as in config/database.yml file for development.

### Installing

The app can be run locally from the project root by using

```
$ rails s
```
Then visiting [localhost:3000](localhost:3000) unless another port is specified.

Local database setup can be done using

```
$ rails db:setup
```

The site should run locally with the capability of user login/sign-up and post creation and viewing.

## Running the tests

To run the RSpec tests, in the root of the project folder simply use the below to run all tests:
```
$ rspec
```
You can also specify the file after this to run specific tests or folders. E.g.
```
$ rspec spec/helpers/posts_helper_spec.rb
```

## Deployment

Deployment can be done with [Heroku](https://www.heroku.com/). Ensure that an add-on for the Postgres database is completed on push or add this manually before running
```
$ heroku rake db:migrate
```
This should make the production site database functional.

## Built With

* [Ruby on Rails](https://rubyonrails.org/) - Ruby framework
* [Bootstrap](https://getbootstrap.com/) - an open source toolkit for developing with HTML, CSS, and JS

## Contributing

N/A

## Versioning

N/A

## License

N/A

## Acknowledgments / Authors

* Credit for this project goes to [Domantas G](https://medium.freecodecamp.org/lets-create-an-intermediate-level-ruby-on-rails-application-d7c6e997c63f)'s tutorial which was worked on with my own alterations made.
