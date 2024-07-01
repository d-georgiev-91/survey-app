
# Survey Application

This is a survey application built with Ruby on Rails, allowing users to vote on surveys created by administrators. Users can view results of finished surveys.

## Prerequisites

Before you start, make sure to have installed the required dependencies:

- Ruby 3.3.1 (using `rbenv` is recommended, details below)
- Ruby Gems (see 'bundler' below)
- MySQL Server 8.0.38
- Redis 7.2.5
- Node.js
- npm
- Yarn

**Note:** Installing Ruby using `rbenv` is covered [here](https://github.com/rbenv/rbenv#installation). There is also a multi-platform installer for `rbenv` (in [this GitHub project](https://github.com/rbenv/rbenv-installer)) which can be executed like this:

```sh
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
```

## Setting up

If this is **the first time** you are setting up the survey-app, you should:

1. Get the [Survey app](https://github.com/d-georgiev-91/survey-app)
   source code from GitHub:
   ```sh
   git clone git@github.com:d-georgiev-91/survey-app.git
   cd survey-app
   ```

1. Make sure the _Redis_ and the _Mysql_ servers are configured properly,
   up and running.

1. Run the automated setup script:

   ```sh
   ./bin/setup
   ```

## Running the survey-app

### Running it locally

You can follow the installation instructions to install [`hivemind`](https://github.com/DarthSim/hivemind?tab=readme-ov-file#installation)

```sh
hivemind Proc.dev
```

### Running it in a Docker container

1. Checkout the `docker-instance` branch:

   ```sh
   git checkout docker-instance
   ```

1. Make sure you have Docker and Docker Compose installed on your machine. If not, you can follow the instructions [here](https://docs.docker.com/get-docker/) and [here](https://docs.docker.com/compose/install/) respectively.

1. Build and run the Docker containers using Docker Compose:

   ```sh
   docker-compose up --build
   ```
