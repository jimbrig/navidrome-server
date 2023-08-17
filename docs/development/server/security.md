# Security

> **Note:** This document is a work in progress.

## Certificate Authority (CA) & SSL/TLS Certificates

> An SSL Certificate is a popular type of Digital Certificate that binds the ownership details of a web server (and website) to cryptographic keys.
> These keys are used in the SSL/TLS protocol to activate a secure session between a browser and the web server hosting the SSL Certificate. In order for a browser to trust an SSL Certificate, and establish an SSL/TLS session without security warnings, the SSL Certificate must contain the domain name of website using it, be issued by a trusted CA, and not have expired.
> - Source: [What is a Certificate Authority? (globalsign.com)](https://www.globalsign.com/en/ssl-information-center/what-are-certification-authorities-trust-hierarchies)

- **Certificate Authority** is an entity that issues digital certificates.

This project utilizes [Caddy](https://caddyserver.com/) as a web server and reverse proxy. Caddy is configured to automatically obtain and renew SSL/TLS certificates from [Let's Encrypt](https://letsencrypt.org/), a free, automated, and open certificate authority.

Caddy Server makes use of an SSL Certificate in the TLS configuration for my domain/sub-domain.

## Local Development

For local development, I use a self-signed certificate. This is a certificate that is signed by the developer, rather than a certificate authority. This is not a certificate that is trusted by browsers, but it is sufficient for local development.

> Using certificates from real certificate authorities (CAs) for development can be dangerous or impossible (for hosts like example.test, localhost or 127.0.0.1), but self-signed certificates cause trust errors. Managing your own CA is the best solution, but usually involves arcane commands, specialized knowledge and manual steps.
> - Source: [FiloSottile/mkcert: A simple zero-config tool to make locally trusted development certificates with any names you'd like. (github.com)](https://github.com/FiloSottile/mkcert#mkcert)

To avoid this, we will learn how to use mkcert tool so we can create local CA and generate locally-trusted certificates.

> Let’s Encrypt is a free, automated, and open certificate authority brought to you by the non-profit Internet Security Research Group (ISRG).
> - Source: [About Let's Encrypt - Let's Encrypt (letsencrypt.org)](https://letsencrypt.org/about/)

To understand why we cannot use it, I recommend reading following links:

-   [Let’s Encrypt — For local development](https://letsencrypt.org/docs/certificates-for-localhost/#for-local-development).
-   [Code with Hugo — Why we can’t use Let’s Encrypt](https://codewithhugo.com/docker-compose-local-https/#why-we-can-t-use-let-s-encrypt).

## Why Not Use Nginx

nginx is fine, however its configuration can be pain for some, specially beginners.

caddy comes with good defaults and easy to configure. It’s a HTTP web-server that defaults to HTTP/2 and HTTPS. It can automatically generate certificates for you using Let’s Encrypt.

## Reverse Proxy vs. Load Balancer

Both act as intermediaries in the communication between the clients and servers.

-   A [**reverse proxy**](https://www.nginx.com/resources/glossary/reverse-proxy-server) accepts a request from a client, forwards it to a server that can fulfill it, and returns the server’s response to the client.

![img](https://miro.medium.com/v2/resize:fit:700/0*xVtKFwemEAWK-ykB)

-   A [**load balancer**](https://www.nginx.com/resources/glossary/load-balancing) distributes incoming client requests among a group of servers, in each case returning the response from the selected server to the appropriate client.

![img](https://miro.medium.com/v2/resize:fit:700/0*x9MQbcgF0uH0QBSF)

So here, we are not looking for balancing some load between apps (servers), we want a reverse-proxy which handles HTTPS requests for public-like domain to the right apps behind it.

## What We Are Going To Do

We will learn how to create local CA, and generate local trusted certificate for ***.foo.bar** domain, so we can make use of it for two subdomains **backend.foo.bar** and **frontend.foo.bar**.

Then we will configure caddy to reverse proxy both the backend & frontend apps so we can run them over HTTPS connections behind it.

**NOTE** — I created two apps (a frontend app using Vue.js and a backend app using node.js) and configured caddy to work for a situation where the frontend app is communicating over HTTPS using cookies in secure mode to make actions that need authorization. Please refer to the [repo](https://rebrand.ly/dev-over-https-traditional-setup-github) for testing the whole project and see it works in your local environment.
