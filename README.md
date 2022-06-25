# Scribble

Use me to take notes.

<br>

---

<br>

## Setup

The application is developed and deployed using Docker containers.  
While using the Docker container for development is not required, it is highly recommended in order to keep development done within a consistent environment.

### Environment Variables

The app depends on various environment variables at different stages.

For local development, these variables are contained in the `docker/.env.development` file for the development environment, and `docker/.env.test` for the test environment.

- `DATABASE_URL` - defines the URL that should be used to connect to the database. required.
- `SMTP_HOST` - defines the host of the SMTP e-mail service used to allow the app to send e-mails. required if using e-mail.
- `SMTP_PORT` - defines the post of the SMTP e-mail service used to allow the app to send e-mails. required if using e-mail.
- `WEB_SESSIONS_SECRET` - secret used to encrypt session cookies. required if using session cookies. 

<br>

## Initialization

Using the Docker container and provided `make` commands, the application can be initiated using the
```
make init
```
command.

This command
1. creates a Docker image using Ruby 2.7.5
2. installs `bundler` and all dependencies needed by the app as defined in the `Gemfile`
3. initializes the development and test databases as defined by the `DATABASE_URL` environment variables

<br>

## Dev Server

After initializing the Docker image, you can start up the development server by running
```
make start
```

By default, this will start the development server at `http://localhost:2300`.  
To run the server on a different port, set the `PORT` environment variable in the `docker/.env.development` file.

<br>

## Dev Console

To start up a developer console, you must first enter the running container with
```
make shell
```

Once in the shell, you can start the development console with
```
bundle exec hanami console
```

<br>

## Linting



<br>

## Testing



<br>

## Database Management



<br>
