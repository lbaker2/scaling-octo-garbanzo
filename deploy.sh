docker build -t lbakerjs/scaling-octo-garbanzo-client:latest -t lbakerjs/scaling-octo-garbanzo-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t lbakerjs/scaling-octo-garbanzo-server:latest -t lbakerjs/scaling-octo-garbanzo-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t lbakerjs/scaling-octo-garbanzo-worker:latest -t lbakerjs/scaling-octo-garbanzo-worker:$GIT_SHA -f ./worker/Dockerfile ./worker
docker push lbakerjs/scaling-octo-garbanzo-client:latest
docker push lbakerjs/scaling-octo-garbanzo-server:latest
docker push lbakerjs/scaling-octo-garbanzo-worker:latest

docker push lbakerjs/scaling-octo-garbanzo-client:$GIT_SHA
docker push lbakerjs/scaling-octo-garbanzo-server:$GIT_SHA
docker push lbakerjs/scaling-octo-garbanzo-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=lbakerjs/scaling-octo-garbanzo-client:$GIT_SHA
kubectl set image deployments/server-deployment server=lbakerjs/scaling-octo-garbanzo-server:$GIT_SHA
kubectl set image deployments/worker-deployment worker=lbakerjs/scaling-octo-garbanzo-worker:$GIT_SHA