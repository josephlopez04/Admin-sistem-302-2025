#!/bin/bash

set -e

echo "Instalando Minikube y kubectl..."

# Instalar dependencias
sudo apt-get update
sudo apt-get install -y curl wget apt-transport-https ca-certificates gnupg lsb-release conntrack

# Instalar kubectl (versión fija)
KUBECTL_VERSION="v1.30.1"
echo "Usando versión fija de kubectl: $KUBECTL_VERSION"
curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl

# Instalar Minikube (última versión estable)
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
rm minikube-linux-amd64

echo "Herramientas instaladas"

echo "Iniciando Minikube"

if [ "$(id -u)" -eq 0 ]; then
    echo "Ejecutando como root. Usando --driver=none."
    minikube start --driver=none
else
    echo "Usuario normal detectado. Usando driver Docker."
    minikube start --driver=docker
fi

echo "Minikube iniciado."

echo "Creando pod y service"

# Crear un namespace
kubectl create namespace flask-demo

# Desplegar Flask app
cat <<EOF | kubectl apply -n flask-demo -f -
apiVersion: v1
kind: ConfigMap
metadata:
  name: flask-config
data:
  MESSAGE: "Hola desde ConfigMap"
---
apiVersion: v1
kind: Secret
metadata:
  name: flask-secret
type: Opaque
data:
  PASSWORD: $(echo -n "supersecreto" | base64)
---
apiVersion: v1
kind: Pod
metadata:
  name: flask-api
spec:
  containers:
  - name: flask
    image: python:3.10-slim
    command: ["sh", "-c"]
    args:
      - pip install flask && echo 'from flask import Flask; import os; app=Flask(_name_); @app.route("/")\ndef home(): return os.getenv("MESSAGE"); app.run(host="0.0.0.0", port=5000)' > app.py && python app.py
    env:
      - name: MESSAGE
        valueFrom:
          configMapKeyRef:
            name: flask-config
            key: MESSAGE
      - name: PASSWORD
        valueFrom:
          secretKeyRef:
            name: flask-secret
            key: PASSWORD
    ports:
    - containerPort: 5000
---
apiVersion: v1
kind: Service
metadata:
  name: flask-service
spec:
  selector:
    app: flask-api
  ports:
    - protocol: TCP
      port: 80
      targetPort: 5000
  type: NodePort
EOF

echo "Pod y Service creados"

echo "Verificando logs"
kubectl logs -n flask-demo pod/flask-api

echo "Exponiendo app con balanceo de carga (NodePort)"
minikube service flask-service -n flask-demo --url

echo "Simulando Rolling Update"
# Crear un deployment con actualización continua
cat <<EOF | kubectl apply -n flask-demo -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: flask-deployment
spec:
  replicas: 2
  selector:
    matchLabels:
      app: flask-roll
  strategy:
    type: RollingUpdate
  template:
    metadata:
      labels:
        app: flask-roll
    spec:
      containers:
      - name: flask
        image: python:3.10-slim
        command: ["sh", "-c"]
        args:
          - pip install flask && echo 'from flask import Flask; app=Flask(_name_); @app.route("/")\ndef home(): return "Rolling Update OK"; app.run(host="0.0.0.0", port=5000)' > app.py && python app.py
        ports:
        - containerPort: 5000
EOF

echo "Rolling Update desplegado."

echo "Gestionando almacenamiento persistente..."

cat <<EOF | kubectl apply -n flask-demo -f -
apiVersion: v1
kind: PersistentVolume
metadata:
  name: flask-pv
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/mnt/data"
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: flask-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 500Mi
EOF

echo "Almacenamiento persistente listo"

echo "Despliegue completo. Puedes verificar con:"
echo "  kubectl get all -n flask-demo"
