FROM nginx:alpine

WORKDIR /var/www/app

RUN apk update

RUN apk add npm git openssh-client bash

EXPOSE 80

CMD ["nginx"]

