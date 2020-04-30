# base image 
FROM node:carbon 

LABEL MAINTAINER="Idrees Ibraheem <idrees.ibraheem@andela.com>"
LABEL application="The Bear Bank"

# the working directory where the application would be started
WORKDIR /app/bear-bank


# clone git repository where application is sitting

RUN git clone https://github.com/TuringCom/React.git /app/bear-bank

# Dependencies are installed here
RUN yarn install

# build the application for production
RUN yarn build

# install serve, a module that allows you to serve the react app forever
RUN  yarn global add serve

# Port to be exposed.
EXPOSE 5000

# command that starts the app
ENTRYPOINT [ "serve", "-s", "build" ]