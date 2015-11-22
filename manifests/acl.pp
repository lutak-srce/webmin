# Define: webmin::acl
define webmin::acl (
  $acl          = [],
  $readonly     = '0',
  $gedit        = '',
  $gedit2       = '',
  $gedit_mode   = '0',
  $uedit        = '',
  $negative     = '0',
  $uedit_mode   = '0',
  $feedback     = '2',
  $root         = '/',
  $rpc          = '2',
  $nodot        = '0',
  $webminsearch = '0',
  $otherdirs    = '',
  $fileunix     = 'root',
  $uedit2       = '',
) {

  $user = $title

  concat::fragment { "webmin_acl:${title}":
    target  => '/etc/webmin/webmin.acl',
    content => template('webmin/acl.erb'),
    order   => '200',
  }

  concat::fragment { "miniserv_users:${title}":
    target  => '/etc/webmin/miniserv.users',
    content => "${title}:x:0",
    order   => '200',
  }

  file { "/etc/webmin/${title}.acl":
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0640',
    content => template('webmin/user_acl.erb'),
    require => Package['webmin'],
    notify  => Service['webmin'],
  }

}
