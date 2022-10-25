docker build -t denk3310/multi-client:latest -t denk3310/multi-client:$SHA -f .client/Dockerfile ./client
docker build -t denk3310/multi-server:latest -t denk3310/multi-server:$SHA -f .server/Dockerfile ./server
docker build -t denk3310/multi-worker:latest -t denk3310/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push denk3310/multi-client:latest
docker push denk3310/multi-server:latest
docker push denk3310/multi-worker:latest
docker push denk3310/multi-client:$SHA
docker push denk3310/multi-server:$SHA
docker push denk3310/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment server=denk3310/multi-client:$SHA
kubectl set image deployments/server-deployment server=denk3310/multi-server:$SHA
kubectl set image deployments/worker-deployment server=denk3310/multi-worker:$SHA