#/usr/bin/env bash
openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -sha256 -days 30 -nodes -subj "/C=AA/ST=State/L=City/O=Company/OU=CompanyUnit/CN=sqyrrl"