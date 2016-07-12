FROM alpine:latest
MAINTAINER Radoslaw 'Goblin' Pieczonka <goblin@pentex.pl>

RUN apk update; apk add ruby ruby-dev ruby-irb build-base curl-dev ;\
    gem install json ;\
    gem install --no-ri --no-rdoc fluentd;\ 
    fluentd --setup ;\
    gem install --no-ri --no-rdoc fluent-plugin-secure-forward ;\
    gem install --no-ri --no-rdoc fluent-plugin-elasticsearch ;\
    apk del ruby-dev build-base curl-dev

CMD ["fluentd"]

