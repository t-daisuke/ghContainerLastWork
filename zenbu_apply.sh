# # k8sのデプロイメントをapply
kubectl apply -f ./aiu-man.yaml
kubectl apply -f ./eoa-man.yaml        
# 再起動　
kubectl rollout restart deployment -n doskoi

watch "kubectl get pods -n doskoi"