# set -eux
# aws ecr get-login-password --profile haruotsu-profile | docker login --username AWS --password-stdin 905418468932.dkr.ecr.us-east-1.amazonaws.com

# docker build -t haruotsu-rails-images:latest ./productRecommendation-system
# docker build -t haruotsu-flask-images:latest ./recommendationEngine
# # docker　imagesを確認
# docker images

# # 作成したdocker imageをタグ付け
# docker tag haruotsu-flask-images 905418468932.dkr.ecr.us-east-1.amazonaws.com/haruotsu-flask-images:latest
# docker tag haruotsu-rails-images 905418468932.dkr.ecr.us-east-1.amazonaws.com/haruotsu-rails-images:latest

# # ECRにpush
# docker push 905418468932.dkr.ecr.us-east-1.amazonaws.com/haruotsu-rails-images:latest
# docker push 905418468932.dkr.ecr.us-east-1.amazonaws.com/haruotsu-flask-images:latest

# # k8sのデプロイメントをapply
kubectl apply -f ./aiu-man.yaml
kubectl apply -f ./eoa-man.yaml        
# 再起動　
kubectl rollout restart deployment service-a-deployment
kubectl rollout restart deployment rservice-b-deployment