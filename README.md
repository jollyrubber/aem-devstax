# aem-devstax

Adobe Experience Manager Development Stack

## Install
- [ChefDK](https://downloads.chef.io/chef-dk/)
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- [Vagrant](https://www.vagrantup.com/downloads.html)
- A Git client because Chef may be cloning remote repositories

Verify the ChefDK installation with
```shell
$ chef verify
```
### Vagrant Plugins

The following plugins are required

```shell
$ vagrant plugin install vagrant-berkshelf
$ vagrant plugin install vagrant-omnibus
$ vagrant plugin install vagrant-hostmanager
```

## Pre Requisites

### Jar & License Files
You must provide a url to the CQ quickstart jar file and license.properties. The url can be on a remote http server `http://example.com/cq-quickstart-6.2.jar`,
or you can put the files in the project directory and reference them as `file:///vagrant/aem/cq-quickstart-6.2.jar`

### Working Under Vagrant

#### Access Points

The following access points are available under vagrant

* http://localhost:4502

### Knife Solo Deployment

Install [Knife Solo](https://matschaffer.github.io/knife-solo)

```shell
$ chef gem install knife-solo
```

Install Chef client on the target node

```shell
$ knife solo prepare username@localhost --bootstrap-version 12.19.36 --node-name aem-qa --ssh-port 22
```
Provision the target nodes, using the `qa` environment

```shell
$ knife solo cook username@localhost --node-name aem-qa --environment qa --forward-agent --ssh-port 22
```

