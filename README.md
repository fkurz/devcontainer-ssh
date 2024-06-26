# devcontainer-ssh

PoC showing how to use SSH remote development with a Dev Container

## About

[Dev Containers][1] provides a common specification for running containers as full-fledged development environments.

Tool support is expanding but in some cases not very mature (e.g. the IntelliJ integration doesn't let you pick the directory to mount as a volume into the container).

A traditional and widely supported way to connect to a remote development environment is using Secure Shell (SSH). Dev Containers—by virtue of being containers—support remote development via SSH if an SSH server is installed. This PoC shows how to do this by using a base image for dev container images that installs and runs an [OpenSSH][2] server.

[1]: https://www.openssh.com/
[2]: https://www.openssh.com/

## Prerequisites

* Node installation (suggested v20+) 
* Docker runtime and Docker CLI (e.g. [Rancher Desktop](https://rancherdesktop.io/) on macOS)
* Installation of [Dev Containers CLI](https://github.com/devcontainers/cli)

## Starting the SSH Dev Container

Run 

```bash 
./scripts/up.sh
```

to build the base image in `.devcontainer/base` and start a Dev Container with Dev Container CLI for the image in 
`.devcontainer/dev`.

## Testing the Dev Container

### Basic check

Run a basic check that the container is running and that the tooling (in this case just `curl`) was installed properly

```bash
./scripts/exec.sh curl -Is example.com
```

### Check `ssh` connection

Connect to the running container with SSH by running

```bash
./scripts/connect.sh 
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

> :information_source: If you encounter the following warning
> 
> > @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
> >  @    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
> > @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
> > ...
> 
> —and if local port 65432 is not used by another process—, delete the entries for
> `localhost:65432` in `~/.ssh/known_hosts`.

## Stopping the SSH Dev Container

Stop the Dev Container by running:

```bash
./scripts/down.sh 
```

