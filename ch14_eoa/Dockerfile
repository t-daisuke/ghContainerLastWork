# ベースイメージとしてRubyを使用
FROM ruby:3.2.3

# 必要なパッケージをインストール
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# アプリケーションディレクトリを作成
RUN mkdir /myapp
WORKDIR /myapp

# GemfileとGemfile.lockをコピー
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

# Gemをインストール
RUN bundle install

# アプリケーションコードをコピー
COPY . /myapp

# ポートを指定
EXPOSE 3001

# サーバーを起動
CMD ["rails", "server", "-b", "0.0.0.0"]