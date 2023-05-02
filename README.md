# Software Tracker Practice App

This is a practice app I made to learn the fundamentals of Ruby on Rails development.

Currently there is no auth and all app functionality is public.

The function of the app is a simple tool to keep track of who is using different software (tools)
in the office. To this end, it has three models: Users, tools, and categories.

The app uses PostgreSQL for the database, and employs its full-text search through the "pg_search" gem.

The database can be seeded with some placeholders with `rails db:seed`, but no associations have been
included in the seed. New users, tools and categories can also be created through the UI, as well as deleted.
All models can also be edited to fit one's purposes.

The associations can be set up through the UI:
* Users can subscribe to tools through their individual page (e.g. "/users/1")
* Tools can also have users added to their subscriber list on their individual pages
* Tools can belong to a category (but don't have to!)
* Tools can be added to a category on the category's individual page
* Tools can also have their category changed on their edit page (e.g. "tools/1/edit")

This app uses RSpec tests, which can be run with `bundle exec rspec spec/<path_to_spec>.rb --format=documentation` to run an individual spec's tests.
