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

# AWS ECRにプッシュする
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

以下、やったこと
```
aws configure
aws ecr create-repository --repository-name dos_img_aiu --profile default
aws ecr create-repository --repository-name dos_img_eoa --profile default
#~/.aws/config と ~/.aws/credentialsに追加されるよ！
aws ecr describe-repositories #確認
#ちなみに、これのrepositoryArnでユーザーidとかわかる
```

```
#ログイン
aws ecr get-login-password --profile default | docker login --username AWS --password-stdin 905418468932.dkr.ecr.us-east-1.amazonaws.com
```
(後述、ここいらないです)
REPOSITORY                      TAG       IMAGE ID       CREATED         SIZE
ghcontainerlastwork-service_a   latest    e40616706fd1   4 days ago      1.32GB
ghcontainerlastwork-service_b   latest    c7fe7d75ebc0   4 days ago      1.31GB
とあるのでそれに倣って
```
#service_aのリポジトリで
docker build -t ghcontainerlastwork-service_a:latest .
#service_bのリポジトリで
docker build -t ghcontainerlastwork-service_b:latest .
```
REPOSITORY                      TAG       IMAGE ID       CREATED          SIZE
ghcontainerlastwork-service_b   latest    6d72d76ddef9   39 seconds ago   1.31GB
ghcontainerlastwork-service_a   latest    c96809b173a8   2 minutes ago    1.32GB
立てられた！

→いらない
```
docker compose build
```
で立てられるのでall ok

tagづけ
```
docker tag ghcontainerlastwork-service_a:latest 905418468932.dkr.ecr.us-east-1.amazonaws.com/dos_img_aiu:latest
docker tag ghcontainerlastwork-service_b:latest 905418468932.dkr.ecr.us-east-1.amazonaws.com/dos_img_eoa:latest
```
push
```
docker push 905418468932.dkr.ecr.us-east-1.amazonaws.com/dos_img_aiu:latest
docker push 905418468932.dkr.ecr.us-east-1.amazonaws.com/dos_img_eoa:latest
```

確認
```
aws ecr list-images --repository-name dos_img_aiu --region us-east-1
aws ecr list-images --repository-name dos_img_eoa --region us-east-1
```

# k８sに認証情報を載せる
```
aws ecr get-login-password --profile default
```
でパスワードを把握し、それを
~/.docker/congfig.jsonに
```
{
	"auths": {
		"905418468932.dkr.ecr.us-east-1.amazonaws.com": {
			"auth": <get-login-passwordのパス>
        }
	}
}
```
このjsonをbase 64にしてSecretとしてk8sに送る

```
kubectl create secret generic ecr-secret --from-file=.dockerconfigjson=/Users/doskoi64/.docker/config.json --type=kubernetes.io/dockerconfigjson
```

→クラスターにアクセスできてない

正解は~/.aws/のプロファイルのdefaultからeksの情報が消えてしまった。
そのため、eksにログインができなくなってしまった。

なので、再度~/.aws/configやcredentialsに入れる

それを適用します
```
aws eks update-kubeconfig --region us-east-1 --name training-cluster --profile dos_eks
#確認
kubectl get pods
kubectl get pods -n haruotsu
```
でk8sにアクセスできるようになりました

```
kubectl create secret generic ecr-secret --from-file=.dockerconfigjson=/Users/doskoi64/.docker/config.json --type=kubernetes.io/dockerconfigjson
kubectl get secrets
```
でちゃんとsecretが入る

# 一方その頃、localのk8sで
