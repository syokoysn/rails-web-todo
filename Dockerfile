FROM ruby:3.0.3
 
# ビルド時に実行するコマンドの指定
# インストール可能なパッケージの一覧の更新
RUN apt-get update -qq \
    # パッケージのインストール（nodejs、npmを指定）
    && apt-get install -y nodejs npm \
    && rm -rf /var/lib/apt/lists/* \
    && npm install --global yarn
 
# 作業ディレクトリの指定
WORKDIR /rails-web-todo
COPY Gemfile /rails-web-todo/Gemfile
COPY Gemfile.lock /rails-web-todo/Gemfile.lock
RUN bundle install
COPY . /rails-web-todo
# # Add a script to be executed every time the container starts.
# COPY entrypoint.sh /usr/bin/
# RUN chmod +x /usr/bin/entrypoint.sh
# ENTRYPOINT ["entrypoint.sh"]
# EXPOSE 3000
# # Configure the main process to run when running the image
# CMD ["rails", "server", "-b", "0.0.0.0"]