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

dockerですること見つけた
```
# もらったECRのシークレットを別のプロファイルとして登録
aws configure --profile haruotsu-profile
	AWS Access Key ID [****************O7WG]: 
	AWS Secret Access Key [****************16ht]: 
	Default region name [us-east-1]: 
	Default output format [json]: 
# 登録したプロファイルを指定してコマンド実行(2つつくる)
aws ecr create-repository --repository-name <your image haruotsu-flask-images> --profile <your profile haruotsu-profile>
aws ecr create-repository --repository-name <your image haruotsu-rails-images> --profile <your profile haruotsu-profile>

# 一回リポジトリちゃんとできているか確認する
aws ecr describe-repositories --profile <your profile>

# awsにログインする
aws ecr get-login-password --profile haruotsu-profile | docker login --username AWS --password-stdin <AWS_ACCOUNT_ID>.dkr.ecr.<REGION>.amazonaws.com

# docker imageをbuild
docker build -t <your image　1つめ>:latest .
docker build -t <your image 2つめ>:latest .

# docker　imagesを確認
docker images

# 作成したdocker imageをタグ付け
docker tag <your image　1つめ> <AWS ID>.dkr.ecr.us-east-1.amazonaws.com/<your image haruotsu-flask-images>:latest
docker tag <your image　2つめ> <AWS ID>.dkr.ecr.us-east-1.amazonaws.com/<your image haruotsu-rails-images>:latest

# タグ付けしたimageをpush
docker tag <your image　1つめ> <AWS ID>.dkr.ecr.us-east-1.amazonaws.com/<your image haruotsu-flask-images>:latest
docker tag <your image　2つめ> <AWS ID>.dkr.ecr.us-east-1.amazonaws.com/<your image haruotsu-rails-images>:latest
```