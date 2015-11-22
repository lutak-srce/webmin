#
# = Class: webmin
#
# This module manages Webmin
#
class webmin (
  $ensure        = 'present',
  $package       = 'webmin',
  $version       = latest,
  $libwrap       = '0',
  $alwaysresolve = '1',
  $allow         = [ '0.0.0.0/0' ],
) {
  include ::yum::repo::webmin
  include ::perl::mod::net::ssleay
  include ::perl::mod::authen::pam

  ### Internal variables (that map class parameters)
  if $ensure == 'present' {
    $package_ensure = $version ? {
      ''      => 'present',
      default => $version,
    }
    $file_ensure = present
  } else {
    $package_ensure = absent
    $file_ensure    = absent
  }

  ### Module code
  package { 'webmin' :
    ensure => $package_ensure,
    name   => $package,
  }

  file { '/etc/webmin/miniserv.conf':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0600',
    content => template('webmin/miniserv.conf.erb'),
    require => Package['webmin'],
  }

  service { 'webmin':
    ensure    => running,
    enable    => true,
    subscribe => File['/etc/webmin/miniserv.conf'],
  }


  # webmin.acl
  concat { '/etc/webmin/webmin.acl':
    owner  => root,
    group  => root,
    mode   => '0600',
    notify => Service['webmin'],
  }
  ::concat::fragment { 'webmin_acl:header':
    target => '/etc/webmin/webmin.acl',
    source => 'puppet:///modules/webmin/webmin.acl',
    order  => '100',
  }

  # miniserv.users
  concat { '/etc/webmin/miniserv.users':
    owner  => root,
    group  => root,
    mode   => '0600',
    notify => Service['webmin'],
  }
  ::concat::fragment { 'miniserv_users:header':
    target => '/etc/webmin/miniserv.users',
    source => 'puppet:///modules/webmin/miniserv.users',
    order  => '100',
  }



}
