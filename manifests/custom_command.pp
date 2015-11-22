# Define: webmin::custom commnad
define webmin::custom_command (
  $command       = '',
  $id            = undef,
  $user          = '',
  $description   = '',
  $documentation = '',
) {

  # Webmin checks if custom command passes '\d+.cmd'
  # regex, and loads it only if it does
  if is_integer($id) {
    $cc_filename = $id
  } else {
    $cc_filename = inline_template('<% require \'zlib\'; crc32=Zlib::crc32(title)%><%= crc32 %>')
  }

  file { "/etc/webmin/custom/${cc_filename}.cmd":
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('webmin/custom_command.erb'),
    require => [ User[$user], Package['webmin'], ],
    notify  => Service['webmin'],
  }

  file { "/etc/webmin/custom/${cc_filename}.html":
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => $documentation,
    require => Package['webmin'],
    notify  => Service['webmin'],
  }


}
