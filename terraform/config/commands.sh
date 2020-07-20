# register services
consul services register /opt/consul/config/frontend-service.hcl
consul services register /opt/consul/config/backend-service.hcl

# run services
# Frontend
docker run -it --rm --network host raykao/hcs-contrived-frontend:latest
# Proxy
consul connect envoy -sidecar-for frontend

# Backend
docker run -it --rm --network host raykao/hcs-contrived-backend:latest
# Proxy
consul connect envoy -sidecar-for backend