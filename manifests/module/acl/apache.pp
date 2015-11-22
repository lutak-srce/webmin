# Define: webmin::module::acl::apache
#
# This definition creates a new ACL configuration for Apache module
#
# Parameters:
#   [*user*]     - Name of the user that will have following privileges.
# Privileges:
#   [*noconfig*] - Edit this webmin's module configuration (0|1)
#   [*create*]   - Create virtual servers
#   [*types*]    - Directive types available
#   [*aliasdir*] - Limit aliases to directory
#   [*vuser*]    - Can change virtual server users
#   [*names*]    - Can edit server names
#   [*stop*]     - Can stop and start Apache
#   [*global*]   - Can edit global options
#   [*pipe*]     - Can pipe logs to programs
#   [*dirsmode*] -
#   [*dir*]      - Limit files to directory
#   [*apply*]    - Can apply changes
#   [*vaddr*]    - Can change virtual server addresses
#   [*dirs*]     -
#   [*virts*]    - Virtual servers this user can edit
#
# Actions:
#
# Requires:
#
# Sample Usage:
#  webmin::module::acl::apache { 'jsosic': }
define webmin::module::acl::apache (
  $user     = $title,
  $noconfig = '1',
  $create   = '1',
  $types    = '*',
  $aliasdir = '/',
  $vuser    = '1',
  $names    = '1',
  $stop     = '1',
  $global   = '1',
  $pipe     = '1',
  $dirsmode = '1',
  $dir      = '/',
  $apply    = '1',
  $vaddr    = '1',
  $dirs     = '',
  $virts    = '*',
) {

  file { "/etc/webmin/apache/${user}.acl":
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0640',
    content => template('webmin/module/apache.erb'),
    require => Package['webmin'],
    notify  => Service['webmin'],
  }

}
