docker build -t judgejab/multi-client:latest -t judgejab/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t judgejab/multi-server:latest -t judgejab/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t judgejab/multi-worker:latest -t judgejab/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push judgejab/multi-client:latest 
docker push judgejab/multi-server:latest
docker push judgejab/multi-worker:latest

docker push judgejab/multi-client:$SHA
docker push judgejab/multi-server:$SHA
docker push judgejab/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=judgejab/multi-server:$SHA
kubectl set image deployments/client-deployment client=judgejab/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=judgejab/multi-worker:$SHA