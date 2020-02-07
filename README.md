#QA BASE

Seed project for e2e and api test



## Getting Started
These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.


### Prerequisites

Para ejecución en local:
- Ruby 2.3.0
- RVM
- Sql Server 2017


## Instalación en Local


Para RVM:
```sh
$ \curl -sSL https://get.rvm.io | bash
```

Para Ruby:
```sh
$ rvm install 2.3.0
```

Crear Gemset:
```sh
$ rvm use 2.3.0
$ rvm gemset create base-qa
$ rvm use 2.3.0@base-qa
```

Para los driver de base de datos
```sh
$ rvm use 2.3.0@base-qa
$ brew install freetds
$ gem install bundler
$ gem install bundle pack
$ bundle install
$ gem install 'activerecord-sqlserver-adapter'

```


## Running the tests in local

```sh
$ cd base-qa
$ cucumber -p local features --format pretty --format html --out docker-html-report.html
```

## To create Database with Docker

```sh
docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=Passw0rd' \
   -p 1433:1433 --name sql1 \
   -d mcr.microsoft.com/mssql/server:2017-latest
```

### To view the reports

In case that load the test in local environment the results of the tests are stored in the target folder as cucumber.json

In case that load the test in Docker environment the results of the tests are stored in the project folder



## Deployment

Add additional notes about how to deploy this on a live system

## Built With

* [Selenium](http://www.seleniumhq.org/) - The web framework used for automates browsers
* [Ruby](https://maven.apache.org/) - Used to make the scripts
* [Docker](https://www.docker.com/) - Used to make Containers
* [Vnc](https://www.realvnc.com/en/connect/download/vnc/) -Used remote access to Selenium-chrome

## Contributing

Please read [CONTRIBUTING.md](https://github.com/myteocafe/falcom_base/blob/master/CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [Github](https://github.com/) for versioning. For the versions available, see the [tags on this repository](https://github.com/myteocafe/tags). 

## Authors

* **Cliff La Torre** - *Initial work* - [Ruby_Cucumber](https://github.com/myteocafe/falcom_base)

See also the list of [contributors](https://github.com/myteocafe/falcom_base/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to anyone who's code was used
* Inspiration
* etc
