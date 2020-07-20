service {
    name = "backend"
    port = 8000
  
    connect {
      sidecar_service {}
    }
  }
  