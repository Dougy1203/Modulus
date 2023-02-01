docker compose up -d

docker tag corp:1.0 liamd1203/corp_microservice
docker tag email:1.0 liamd1203/email_microservice
docker tag mod:1.0 liamd1203/mod_microservice
docker tag user:1.0 liamd1203/user_microservice
docker tag steeltoeoss/eureka-server liamd1203/eureka_microservice
docker tag apigateway:1 liamd1203/gateway_microservice

docker push liamd1203/corp_microservice
docker push liamd1203/email_microservice
docker push liamd1203/mod_microservice
docker push liamd1203/user_microservice
docker push liamd1203/eureka_microservice
docker push liamd1203/gateway_microservice

az login