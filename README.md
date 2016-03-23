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
You must provide a url to the CQ quickstart jar file and license.properties. The url can be on a remote http server `http://example.com/cq-quickstart-5.6.1.jar`,
or you can put the files in the project directory and reference them as `file:///vagrant/aem/cq-quickstart-5.6.1.jar`

### A note on my particular Jar file
I am using Java 8 SDK with AEM 5.6.1. To do this I had to add service pack to the AEM jar file, along with the Sightly feature pack
- [AEM 5.6.1 Service Pack 2 on PackageShare](https://www.adobeaemcloud.com/content/marketplace/marketplaceProxy.html?packagePath=/content/companies/public/adobe/packages/cq561/servicepack/AEM-561-Service-Pack-2)
- [Sightly FP 1.1 - AEM 6.1 Sightly scripting engine for CQ 5.6.1 - 6.0](https://www.adobeaemcloud.com/content/marketplace/marketplaceProxy.html?packagePath=/content/companies/public/adobe/packages/cq600/featurepack/cq-6.0.0-featurepack-6431)

The packages are added to the `static\install` directory such that if I use `jar tf cq-quickstart-5.6.1.jar` I get the following
```
...
static/install/AEM 5.6.1 Service Pack 2-1.0.zip
static/install/cq-6.0.0-featurepack-6431-1.0.0.zip
```
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
$ knife solo prepare username@localhost --bootstrap-version 12.8.1 --node-name aem-author-publish --ssh-port 22
```
Provision the target nodes, using the `qa` environment

```shell
$ knife solo cook username@localhost --node-name aem-author-publish --environment qa --forward-agent --ssh-port 22
```

