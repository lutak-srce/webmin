# Define: webmin::module::acl::mysql
#
# This definition creates a new ACL configuration for MySQL module
#
# Parameters:
#   [*user*]     - Name of the user that will have following privileges.
# Privileges:
#   [*noconfig*] - Edit this webmin's module configuration (0|1)
#   [*create*]   - Create new databases (0|1|max)
#   [*max*]      - Maximum databases allowed to create - if *create* is set to 1 (int)
#   [*stop*]     - Stop and start MySQL server (0|1)
#   [*dbs*]      - Manage only the following databases.
#   [*views*]    - View and manage views.
#   [*edonly*]   - Only edit table data.
#   [*delete*]   - Drop databases.
#   [*perms*]    - Edit permissions
#   [*indexes*]  - View and manage indexes.
#   [*buser*]    - Backup unix user.
#   [*bpath*]    - Backup file path.
#
# Actions:
#
# Requires:
#
# Sample Usage:
#  webmin::module::acl::mysql { 'jsosic': }
define webmin::module::acl::mysql (
  $user     = $title,
  $noconfig = '1',
  $create   = '1',
  $max      = '',
  $stop     = '1',
  $dbs      = '*',
  $views    = '1',
  $edonly   = '0',
  $delete   = '1',
  $perms    = '1',
  $indexes  = '1',
  $buser    = 'root',
  $bpath    = '/',
) {

  file { "/etc/webmin/mysql/${user}.acl":
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0640',
    content => template('webmin/module/mysql.erb'),
    require => Package['webmin'],
    notify  => Service['webmin'],
  }

}
