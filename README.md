# Scribble

Use me to take notes.

<br>

---

<br>

## Setup

Make sure you have Ruby `2.7.5` installed (you can also use RVM):
```
% rvm use
```

Install the required dependencies:
```
% bundle install
```

### Environment Variables

The app requires certain environment variables in order to function.

Create a `.env` file (which will not be checked into version control) and fill out the following values:
```
DATABASE_URL=postgres://<username>:<password>@<host>:<port>/<database>
```

<br>

## Database Management

Running pending migrations (overwrites `schema.sql`):
```
% bundle exec rake db:migrate
```

Re-create the database from scratch and run any pending migrations (overwrites `schema.sql`):
```
% bundle exec rake db:prepare
```

Re-create the database from scratch without running any pending migrations (loads from `schema.sql`):
```
% bundle exec rake db:reset
```

Load the schema into an existing database:
```
% bundle exec rake db:load
```

Prepare (create and migrate) DB for `development` and `test` environments:
```
% HANAMI_ENV=test bundle exec rake db:prepare
```

<br>

## Dev Console

Run the development console:
```
% bundle exec hanami console
```

<br>

## Dev Server

Run the development server:
```
% bundle exec hanami server
```

This will load the server at [http://localhost:2300](http://localhost:2300)

<br>

## Linting

Running all linters:
```
% bundle exec rake lint
```

Running just the style linter:
```
% bundle exec rake lint:style
```

Running just the code smell linter:
```
% bundle exec rake lint:smell
```

<br>

## Testing

How to run tests:
```
% bundle exec rake
```
