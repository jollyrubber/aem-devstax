# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

    Vagrant.require_version '>= 1.9.1'

    # use omnibus to install latest chef
    config.omnibus.chef_version = '12.19.36'

    # enable berkshelf support
    config.berkshelf.enabled = true

    if Vagrant.has_plugin?('vagrant-cachier')
        # cache stuff
        config.cache.scope = :box
    end

    if Vagrant.has_plugin?('vagrant-vbguest')
        # disable vbguest additions as the vbox already has it
        config.vbguest.auto_update = false
    end

    if Vagrant.has_plugin?('vagrant-hostmanager')
        # hostmanager will update host and guest host files
        config.hostmanager.enabled = true
        config.hostmanager.manage_host = true
        config.hostmanager.manage_guest = true
    end

    config.vm.box = 'bento/centos-7.3'

    config.vm.provision :chef_zero do |chef|

        chef.log_level = :warn
        chef.environments_path = 'environments'
        chef.roles_path = 'roles'
        chef.nodes_path = 'nodes'
    end

    config.vm.define :aem, primary: true do |aem|

        aem.vm.hostname = 'aem-vagrant'

        aem.vm.provider :virtualbox do |v|
            v.memory = 8192
            v.cpus = 2
        end

        aem.vm.network :forwarded_port, guest: 8000, host: 8000, auto_correct: true # dispatcher
        aem.vm.network :forwarded_port, guest: 4502, host: 4502, auto_correct: true # author instance
        aem.vm.network :forwarded_port, guest: 4503, host: 4503, auto_correct: true # publish instance
        aem.vm.network :forwarded_port, guest: 30303, host: 30303, auto_correct: true # author instance debug
        aem.vm.network :forwarded_port, guest: 30304, host: 30304, auto_correct: true # publish instance debug

    end

end
