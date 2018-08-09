#PHP72

This cookbook provides a simple customresource for installing php7.2 on AWS
Linux 1.
In order to use this you must include it in your recipe's metadata.

To call the resource, use the "php72" resource.

By default this resource installs only the php72-php-cli and php72-php-fpm
packages. To install additional php packages, use the php_packages property
with an array of packages names, for example:

php72 'install php72 w cli' do
  php_packages ['php72-php-cli', 'php72-php-fpm']
end

Note on package name "php72": this package installs a mandatory dependency on
httpd24, which we don't necessarily want on all our systems. By default this
cookbook is designed to install php7.2 without this, and please keep this in
mind if you choose to install the package named "php72".
