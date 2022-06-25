# Scribble

<br>

I help you stay organized.

<br>

---

<br>

## Setup

<br>

The application is developed and deployed using Docker containers.  
While using the Docker container for development is not required, it is highly recommended in order to keep development done within a consistent environment.

<br>

### Environment Variables

<br>

The app depends on various environment variables at different stages.

For local development, these variables are contained in the `docker/.env.development` file for the development environment, and `docker/.env.test` for the test environment.

- `DATABASE_URL` - defines the URL that should be used to connect to the database. required.
- `SMTP_HOST` - defines the host of the SMTP e-mail service used to allow the app to send e-mails. required if using e-mail.
- `SMTP_PORT` - defines the post of the SMTP e-mail service used to allow the app to send e-mails. required if using e-mail.
- `WEB_SESSIONS_SECRET` - secret used to encrypt session cookies. required if using session cookies. 

<br>

## Initialization

<br>

The application can be initialized using with
```
make init
```

<br>

This command
1. creates a Docker image using Ruby 2.7.5
2. installs `bundler` and all dependencies needed by the app as defined in the `Gemfile`
3. initializes the development and test databases as defined by the `DATABASE_URL` environment variables

<br>

## Dev Server

<br>

After initializing the Docker image, you can start the container and development server with
```
make start
```
This will start the development server at `http://localhost:2300`.

<br>

## Dev Console

<br>

To start up a developer console, you must first enter the running container with
```
make shell
```

<br>

Once in the container, you can start the development console with
```
bundle exec hanami console
```

<br>

## Linting

<br>

You can run the linter with
```
make lint
```

<br>

This will lint all of the files in the application.  
If you want to lint specific files, you can pass them as an argument to the lint command
```
make lint apps/web/controllers/dashboard/index.rb
```

<br>

## Testing

<br>

You can run the specs with
```
make test
```

<br>

This will run all of the specs for the application.  
If you want to run specific specs, you can pass them as an argument to the test command
```
make test spec/web/controllers/dashboard/index_spec.rb
```
