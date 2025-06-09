#!/bin/bash

echo "Iniciando despliegue de Flask en Kubernetes con Minikube..."

# Verifica si kubectl está disponible
if ! kubectl version --client &>/dev/null; then
  echo "kubectl no está instalado o no puede conectarse al clúster."
  exit 1
fi

# Crear namespace
echo "Creando namespace 'flask-demo'"
kubectl create namespace flask-demo --dry-run=client -o yaml | kubectl apply -f -

# Crear ConfigMap, Secret, Pod y Service
echo "Aplicando manifiestos de ConfigMap, Secret, Pod y Service..."
kubectl apply -n flask-demo -f - <<EOF
apiVersion: v1
kind: ConfigMap
metadata:
  name: flask-config
data:
  MESSAGE: "Hola desde Flask en Kubernetes!"
---
apiVersion: v1
kind: Secret
metadata:
  name: flask-secret
type: Opaque
stringData:
  PASSWORD: "secreto123"
---
apiVersion: v1
kind: Pod
metadata:
  name: flask-api
  labels:
    app: flask-api
spec:
  containers:
    - name: flask
      image: python:3.10-slim
      ports:
        - containerPort: 5000
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
      command: ["sh", "-c"]
      args:
        - |
          pip install flask && \
          printf '%s\n' \
"from flask import Flask" \
"import os" \
"" \
"app = Flask(_name_)" \
"" \
"@app.route('/')" \
"def home():" \
"    return os.getenv('MESSAGE')" \
"" \
"if _name_ == '_main_':" \
"    app.run(host='0.0.0.0', port=5000)" > app.py && \
          python app.py
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
      port: 5000
      targetPort: 5000
  type: NodePort
EOF

# Esperar que el pod esté listo
echo "Esperando que el pod esté listo (90s máx)..."
kubectl wait --for=condition=Ready pod/flask-api -n flask-demo --timeout=90s || echo "El pod no está listo. Puedes revisar con: kubectl logs flask-api -n flask-demo"

# Obtener URL del servicio
echo "Comando para acceder al Flask:"
minikube service flask-service -n flask-demo --url
