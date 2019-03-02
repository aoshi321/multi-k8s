docker build -t aoshi/multi-client:latest -t aoshi/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t aoshi/multi-server:latest -t aoshi/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t aoshi/multi-worker:latest -t aoshi/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push aoshi/multi-client:latest
docker push aoshi/multi-server:latest
docker push aoshi/multi-worker:latest 

docker push aoshi/multi-client:$SHA
docker push aoshi/multi-server:$SHA
docker push aoshi/multi-worker:$SHA 


kubectl apply -f k8s
kubectl set image deployments/server-deployment server=aoshi/multi-server:$SHA
kubectl set image deployments/client-deployment server=aoshi/multi-client:$SHA
kubectl set image deployments/worker-deployment server=aoshi/multi-worker:$SHA
