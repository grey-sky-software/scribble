# Notary

Use me to take notes.

## Setup

How to run tests:
```
% bundle exec rake
```

How to run the development console:
```
% bundle exec hanami console
```

How to run the development server:
```
% bundle exec hanami server
```

### Database Management

Running pending migrations:
```
% bundle exec rake db:migrate
```

Re-create the database from scratch and run any pending migrations:
```
% bundle exec rake db:prepare
```

Re-create the database from scratch without running any pending migrations:
```
% bundle exec rake db:reset
```

Load the schema into an existing database:
```
% bundle exec rake db:load
```

How to prepare (create and migrate) DB for `development` and `test` environments:
```
% bundle exec hanami db prepare

% HANAMI_ENV=test bundle exec hanami db prepare
```

Explore Hanami [guides](https://guides.hanamirb.org/), [API docs](http://docs.hanamirb.org/1.3.5/), or jump in [chat](http://chat.hanamirb.org) for help. Enjoy! 🌸
