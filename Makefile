deploy:
	kubectl apply -f nginx-deployment.yml
	kubectl apply -f nginx-service.yml
	cat nginx-ingress.yml | sed "s/{{SERVICE_HOSTNAME}}/${SERVICE_HOSTNAME}/g" | kubectl apply -f -
