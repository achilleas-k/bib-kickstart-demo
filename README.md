# Demo: Custom kickstarts in ISOs built using bootc-image-builder

> 2024-08-05

Recently we added the ability to inject a custom kickstart file into an ISO build using bootc-image-builder.  This kickstart file can be used to configure any part of the installation process, except the deployment of the payload.  In the case of ISOs with bootc container payloads, this means that users can use a kickstart file to configure anything except the `ostreecontainer` command.

Even more recently (not yet released), we added the ability for users to configure the Anaconda installer by enabling or disabling specific udev modules.  I wont go into all the details of what each module is for, but this becomes important when user creation comes into play.  More on that later.

## Part 0: bootc-image-builder

I'll be using a bootc-image-builder image that I built myself to include the aforementioned installer module configuration:
```
quay.io/achilleas/bootc-image-builder:demo
```

This feature should be available in the upstream (`centos-bootc`) image soon.

## Part 1: Partial kickstart file

We'll make an ISO with a kickstart file that takes care of locales etc but is not enough for a fully automated installation.  Some interaction will be required.


```toml
[customizations.installer.kickstart]
contents = """
lang en_GB.UTF-8
keyboard uk
timezone CET
"""
```

This kickstart is missing two important configurations for a fully automated installation:
- Partitioning
- User creation

## Part 2: Fully unattended kickstart file

Let's fully automate the installation by adding user creation and partition instructions.

```toml
[customizations.installer.kickstart]
contents = """
lang en_GB.UTF-8
keyboard uk
timezone CET

user --name achilleas --password password42 --plaintext --groups wheel
sshkey --username achilleas "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPqEtsCdSozq0DT8sOazpizsBP65Ni6SMqrQA85Wnfs1 achilleas"
rootpw --lock

zerombr
clearpart --all --initlabel
autopart --type=plain
reboot --eject
"""
```
