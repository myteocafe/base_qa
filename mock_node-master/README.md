# Mock-Server #

Mock-Server is an open source project that can be used for mocking any system you integrate with via HTTP or HTTPS (i.e. services, web sites, etc).

More information can be found in http://www.mock-server.com

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisities

* Linux, MacOS X or Windows
* Docker: http://www.docker.com

### Building and Running using Docker Compose

To download mockserver jar (prerequisite):

```
cd server
sudo chmod 777 download.sh
./download.sh
```

To build and  run containers with Docker Compose:

```
cd ../
docker-compose up
```

Enjoy it!

### Building and Running using Docker conventionally

#### Building

To build mockserver container:

```
cd server
./download.sh
docker build . -t teocafe/mockserver:latest
```

To build mockserver client container:

```
cd client
docker build . -t teocafe/mockclient:latest
```

#### Running

To run mock server container use the following command changing <host port> with the port where your application requires the mock server.

```
docker run --name mockserver -p <host port>:8080 teocafe/mockclient:latest
```

To run mock server client container use the following command changing <.js dir> with full path directory where the *.js mock files are.

```
docker run -v <.js dir>:/opt/mock --link mockserver teocafe/mockclient:latest
```

Enjoy it!

## How does it work?

Add mock apis with js files in [mocks](./mocks) folder, like as **test.js** example

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](http://www.modlost.net).

## Deploying

TO-DO

## Authors

* **CLiff La Torre** - *Initial work* - [modlost](http://www.modlost.net)

## License

This project is personal and for academic use. Unauthorized use will be punished!

## Acknowledgments

to my countless colleagues who I do not stop learning and for allowing us to use the best tools to do what we are passioned about... software development!

## More information about mockserver in

(Mockserver)[https://www.npmjs.com/package/mockserver-client]