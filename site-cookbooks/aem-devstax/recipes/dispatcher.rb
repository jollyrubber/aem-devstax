include_recipe 'apache2::mod_include'

# PART 1: set up the dispatcher farm

vars = {}
# need the right kind of "empty"
var_list = {
    client_headers: :array,
    virtual_hosts: :array,
    renders: :array,
    statistics: :array,
    filter_rules: :hash,
    cache_rules: :hash,
    invalidation_rules: :hash,
    allowed_clients: :hash,
    ignore_url_params: :hash,
    cache_root: :scalar,
    farm_dir: :scalar,
    farm_name: :scalar,
    cache_opts: :array,
    session_mgmt: :hash,
    enable_session_mgmt: :scalar
    }
empty = { array: [], hash: {}, scalar: nil }

# take value passed to provider, or node attribute, or empty
var_list.keys.each do |var|
    type = var_list[var]
    nothing = empty[type]
    vars[var] = node[:aem][:dispatcher][var] || nothing
end

template "#{vars[:farm_dir]}/farm_#{vars[:farm_name]}.any" do
    source 'farm.any.erb'
    group node[:apache][:root_group]
    mode '0664'
    variables(vars)
    notifies :restart, resources(service: 'apache2')
end

# PART 2: set up the apache site

aem_website vars[:farm_name] do
    template_name 'aem_dispatcher.conf.erb'
    template_cookbook 'aem-devstax'
    action :add
end
