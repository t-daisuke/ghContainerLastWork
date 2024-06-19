# ghContainerLastWork
コンテナ研修の最終課題のためのものです

```
docker-compose build

docker-compose run service_a bundle exec rails db:create
docker-compose run service_a bundle exec rails db:migrate

docker-compose run service_b bundle exec rails db:create
docker-compose run service_b bundle exec rails db:migrate

docker-compose up
```

```
docker compose up --build
```
で行けるらしい

コンテナイメージでシェルが使えるのであれば、 docker exec -it <container-id> <shell> で中に入れるので、それでデバッグするというのも手です!あるいは、 RUN ディレクティブで確認するという方法もあります!

とのお言葉

問題発生
