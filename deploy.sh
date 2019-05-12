docker build -t thevishalnair/multi-client:latest -t thevishalnair/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t thevishalnair/multi-server:latest -t thevishalnair/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t thevishalnair/multi-worker:latest -t thevishalnair/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push thevishalnair/multi-client:latest
docker push thevishalnair/multi-server:latest
docker push thevishalnair/multi-worker:latest

docker push thevishalnair/multi-client:$SHA
docker push thevishalnair/multi-server:$SHA
docker push thevishalnair/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=thevishalnair/multi-server:$SHA
kubectl set image deployments/client-deployment client=thevishalnair/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=thevishalnair/multi-worker:$SHA