# devcontainer-ssh

PoC showing how to use SSH remote development with a Dev Container

## Prerequisites

* Node installation (suggested v20+) 
* Docker runtime and Docker CLI (e.g. [Rancher Desktop](https://rancherdesktop.io/) on macOS)
* Installation of [Dev Containers CLI](https://github.com/devcontainers/cli)

## Set up

```bash 
docker build \
    --tag devcontainer-base-image:latest \
    --file .devcontainer/devcontainer-base-image/Dockerfile \
    .devcontainer/devcontainer-base-image
devcontainer \
    --workspace-folder . \
    up \
        --id-label=containers.dev/id=thedevcontainer
```

Connect to the running container with SSH by running
```bash
ssh ssh-user@localhost -p 65432
```
confirm that you want to connect and enter the password of ssh-user ("password123").
You should see something like this
```bash
Welcome to Ubuntu 22.04.4 LTS (GNU/Linux 6.6.14-0-virt aarch64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

This system has been minimized by removing packages and content that are
not required on a system that users do not log into.

To restore this content, you can run the 'unminimize' command.

The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

ssh-user@88c096c27f33:~$
```

> :bulb: If you encounter the following warning
> > @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
> >  @    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
> > @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
> > ...
> —and if local port 65432 is not used by another process—, delete the entries for
> `localhost:65432` in `~/.ssh/known_hosts`.

Test that the tooling installed in the Dev Container (just `curl` in this case) works by curl'ing a 
sample website. For example,

```bash
$ curl -IL example.com
HTTP/1.1 200 OK
Content-Encoding: gzip
Accept-Ranges: bytes
Age: 5040
Cache-Control: max-age=604800
Content-Type: text/html; charset=UTF-8
Date: Thu, 18 Apr 2024 20:06:13 GMT
Etag: "3147526947+gzip"
Expires: Thu, 25 Apr 2024 20:06:13 GMT
Last-Modified: Thu, 17 Oct 2019 07:18:26 GMT
Server: ECAcc (mid/871E)
X-Cache: HIT
Content-Length: 648
```

Stop the Dev Container by running:
```bash
id="$(docker ps --filter=label=containers.dev/id=thedevcontainer --quiet)"
if [ -n "$id" ]; then 
  docker stop "$id"
  docker remove "$id" 
fi
```