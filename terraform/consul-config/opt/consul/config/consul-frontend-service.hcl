service {
  name = "frontend"
  port = 8080

  connect {
    sidecar_service {
      proxy {
        upstreams = [
          {
            destination_name = "backend"
            local_bind_port  = 3000
          }
        ]
      }
    }
  }
}