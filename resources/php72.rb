resource_name :php72

property :php_packages, Array, default: ['php72-cli', 'php72-fpm']

action :create do
  # Uninstall system default php.
  package 'php-common' do
    action :remove
  end

  # Install repo dependencies for php 7.2.
  package 'epel-release'
  package 'yum-utils'

  remote_file '/tmp/remi-release-6.rpm' do
    source 'http://rpms.remirepo.net/enterprise/remi-release-6.rpm'
  end

  rpm_package '/tmp/remi-release-6.rpm'

  execute 'yum-config-manager --enable epel'

  execute 'yum-config-manager --enable remi-php72'

  # # Occasionally testkitchen has had issues with timing on this the yum 
  # # enables; this is my hacky fix. It never seems to come up on regular servers.
  # ruby_block 'wait for yum enable' do
  #   block do
  #     iter=0
  #     while ::File.readlines("/etc/yum.repos.d/remi-php72.repo").grep(/enabled=1/).size <= 0  || iter > 10 do
  #       sleep 1
  #       iter += 1
  #     end
  #     raise "Timeout waiting for remi-php72 yum enable." unless iter <= 10
  #   end
  # end


  # Install php 7.2 package and modules.
  new_resource.php_packages.each do |p|
    package p do
      action :install
    end
  end

end
