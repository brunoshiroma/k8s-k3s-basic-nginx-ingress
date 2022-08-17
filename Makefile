deploy:
	kubectl apply -f nginx-deployment.yml
	kubectl apply -f nginx-service.yml
	cat nginx-ingress.yml | sed "s/{{SERVICE_HOSTNAME}}/${SERVICE_HOSTNAME}/g" | kubectl apply -f -

install-ingress:
	helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
	helm install ingress-nginx ingress-nginx/ingress-nginx --set "controller.service.externalIPs={172.19.0.2}" --set "controller.customPorts={60080}"