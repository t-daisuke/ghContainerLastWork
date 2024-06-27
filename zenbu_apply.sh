set -eux
aws ecr get-login-password --profile dos_prf | docker login --username AWS --password-stdin 905418468932.dkr.ecr.us-east-1.amazonaws.com

docker build -t dos_img_aiu:latest ./ch14_aiu
docker build -t dos_img_eoa:latest ./ch14_eoa

# # docker　imagesを確認
docker images

# # 作成したdocker imageをタグ付け
docker tag dos_img_aiu 905418468932.dkr.ecr.us-east-1.amazonaws.com/dos_img_aiu:latest
docker tag dos_img_eoa 905418468932.dkr.ecr.us-east-1.amazonaws.com/dos_img_eoa:latest

# # ECRにpush
docker push 905418468932.dkr.ecr.us-east-1.amazonaws.com/dos_img_aiu:latest
docker push 905418468932.dkr.ecr.us-east-1.amazonaws.com/dos_img_eoa:latest

# # k8sのデプロイメントをapply
kubectl apply -f ./aiu-man.yaml
kubectl apply -f ./eoa-man.yaml        
# 再起動　
kubectl rollout restart deployment -n doskoi