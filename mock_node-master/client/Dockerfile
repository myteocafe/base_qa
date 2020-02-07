FROM node:6.2.2-slim
WORKDIR /opt
ADD package.json /opt/package.json
RUN npm install
ENTRYPOINT ["/bin/bash","-c","sleep 2;find . -name '*.js' | grep -v node_modules | while read line; do node $line; done"]
