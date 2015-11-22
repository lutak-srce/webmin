# Define: webmin::module::config
define webmin::module::config (
  $settings,
  $notify_service = true,
) {
  include ::webmin

  $service_to_notify = $notify_service ? {
    default => undef,
    true    => Service['webmin'],
  }

  file { "/etc/webmin/${name}/config":
    ensure  => file,
    content => template('webmin/module_config.erb'),
    owner   => 'root',
    group   => 'bin',
    mode    => '0600',
    require => Package['webmin'],
    notify  => $service_to_notify,
  }

}
