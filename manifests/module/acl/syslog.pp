# Define: webmin::module::acl::syslog
#
# This definition creates a new ACL configuration for SYSLOG module
#
# Parameters:
#   [*user*]     - Name of the user that will have following privileges.
# Privileges:
#   [*noconfig*] - Edit this webmin's module configuration (0|1)
#   [*extras*]   - Extra log files for this user
#   [*noedit*]   - Can only view logs
#   [*others*]   - Can view logs from other modules
#   [*syslog*]   - Can view logs from syslog
#   [*any*]      - Can view any file as log
#   [*logs*]     - Can view and configure log files
#
# Actions:
#
# Requires:
#
# Sample Usage:
#  webmin::module::acl::syslog { 'jsosic': }
define webmin::module::acl::syslog (
  $user     = $title,
  $noconfig = '1',
  $extras   = '',
  $noedit   = '0',
  $others   = '1',
  $syslog   = '1',
  $any      = '1',
  $logs     = '',
) {

  file { "/etc/webmin/syslog/${user}.acl":
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0640',
    content => template('webmin/module/syslog.erb'),
    require => Package['webmin'],
    notify  => Service['webmin'],
  }

}
