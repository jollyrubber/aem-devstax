include_recipe 'ark::default'

# install maven via ark
version = '3.3.3'
m2_home = '/usr/local/maven'
ark 'maven' do
    version version
    url "http://apache.mirrors.tds.net/maven/maven-#{version.split('.')[0]}/#{version}/binaries/apache-maven-#{version}-bin.tar.gz"
    home_dir m2_home
    append_env_path true
end

# setup environmental variables
template '/etc/mavenrc' do
    source 'mavenrc.erb'
    mode   '0755'
    variables({
        :m2_home => m2_home
    })
end

# install other packages via yum
%w(multitail nano).each do |pkg|

    yum_package pkg

end
