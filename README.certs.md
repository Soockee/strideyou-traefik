# Traefik v2 HTTPS (SSL) on localhost

Generate certificates using [mkcert](https://github.com/FiloSottile/mkcert) :

```bash
# If it's the firt install of mkcert, run
mkcert -install

# Generate certificate for domain "docker.localhost", "domain.local" and their sub-domains
mkcert -cert-file certs/local-cert.pem -key-file certs/local-key.pem "docker.localhost" "*.docker.localhost" "domain.local" "*.domain.local"
```

After deployment ( dev environment ) you can go to your browser at [backend.docker.localhost:4443](https://backend.docker.localhost:4443), enjoy :rocket: !

_Note: you can access to Træfik dashboard at: [traefik.docker.localhost/dashboard/](https://traefik.docker.localhost/dashboard/)_
