build:
	mvn spring-boot:build-image

bootstrap:
	cd terraform/bootstrap && terraform init  && terraform apply -auto-approve && cd ../..

push:
	aws ecr get-login-password --region eu-west-1 --profile fredericci | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.eu-west-1.amazonaws.com
	docker push ${AWS_ACCOUNT_ID}.dkr.ecr.eu-west-1.amazonaws.com/fredericci/spring-restapi:0.0.1-SNAPSHOT

deploy:
	cd terraform/apprunner && terraform init  && terraform apply -auto-approve && cd ../..

all:
	make build
	make bootstrap
	make push
	make deploy

destroy:
	cd terraform/apprunner && terraform init && terraform destroy -auto-approve && cd ../..
	cd terraform/bootstrap && terraform init && terraform destroy -auto-approve && cd ../..