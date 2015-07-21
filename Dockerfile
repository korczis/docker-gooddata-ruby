FROM ruby:2.1-onbuild

WORKDIR /root

COPY . /usr/src/app

CMD ["/usr/src/app/app.rb"]