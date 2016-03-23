# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

    Vagrant.require_version '>= 1.8.1'

    # use omnibus to install latest chef
    config.omnibus.chef_version = :latest

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

    config.vm.box = 'bento/centos-7.1'

    config.vm.network :forwarded_port, guest: 4502, host: 4502, auto_correct: true # author instance
    config.vm.network :forwarded_port, guest: 30303, host: 30303, auto_correct: true # author instance debug

    config.vm.provider 'virtualbox' do |v|
        v.memory = 8192
        v.cpus = 2
    end

    config.vm.provision :chef_solo do |chef|

        chef.log_level = :info

        chef.environments_path = 'environments'
        chef.roles_path = 'roles'

        chef.environment = 'vagrant'

        chef.add_role 'aem-dev'

    end

end
