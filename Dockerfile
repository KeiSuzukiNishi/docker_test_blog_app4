# テキストのバージョンであるRuby3.3.0に揃える
FROM ruby:3.3.0
 
RUN wget --quiet -O - /tmp/pubkey.gpg https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
 
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client yarn
RUN mkdir /docker_test_blog_app4
WORKDIR /docker_test_blog_app4
COPY Gemfile /docker_test_blog_app4/Gemfile
COPY Gemfile.lock /docker_test_blog_app4/Gemfile.lock
RUN gem install nokogiri --platform=ruby
RUN bundle config set force_ruby_platform true
RUN bundle install
COPY . /docker_test_blog_app4
 
# コンテナ起動時に毎回実行する
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
 
# rails s　実行.
CMD ["rails", "server", "-b", "0.0.0.0"]