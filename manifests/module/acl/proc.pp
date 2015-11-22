# Define: webmin::module::acl::proc
#
# This definition creates a new ACL configuration for PROC module
#
# Parameters:
#   [*user*]     - Name of the user that will have following privileges.
# Privileges:
#   [*noconfig*] - Edit this webmin's module configuration (0|1)
#   [*run*]      - Can run commands
#   [*only*]     - Can only see own processes
#   [*uid*]      - Manage processes as user UID
#   [*users*]    - Can manage processes for users
#   [*edit*]     - ?
#
# Actions:
#
# Requires:
#
# Sample Usage:
#  webmin::module::acl::proc { 'jsosic': }
define webmin::module::acl::proc (
  $user     = $title,
  $noconfig = '1',
  $run      = '1',
  $only     = '0',
  $uid      = '0',
  $users    = '*',
  $edit     = '1',
) {

  file { "/etc/webmin/proc/${user}.acl":
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0640',
    content => template('webmin/module/proc.erb'),
    require => Package['webmin'],
    notify  => Service['webmin'],
  }

}
