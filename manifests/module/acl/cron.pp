# Define: webmin::module::acl::cron
#
# This definition creates a new ACL configuration for Cron module
#
# Parameters:
#   [*user*]     - Name of the user that will have following privileges.
# Privileges:
#   [*noconfig*] - Edit this webmin's module configuration (0|1)
#   [*create*]   - Can create cron jobs
#   [*move*]     - Can move cron jobs
#   [*hourly*]   - Limit jobs to at most hourly
#   [*kill*]     - Can terminate cron jobs
#   [*delete*]   - Can delete cron jobs
#   [*command*]  - Can view and edit cron commands
#   [*allow*]    - ?
#   [*mode*]     - ?
#   [*users*]    - Can edit cronjobs for
#   [*uidmin*]   - Users with uid in range (from MIN)
#   [*uidmax*]   - Users with uid in range (to MAX)
#
# Actions:
#
# Requires:
#
# Sample Usage:
#  webmin::module::acl::cron { 'jsosic': }
define webmin::module::acl::cron (
  $user     = $title,
  $noconfig = '1',
  $create   = '1',
  $move     = '1',
  $hourly   = '2',
  $kill     = '1',
  $delete   = '1',
  $command  = '1',
  $allow    = '1',
  $mode     = '0',
  $users    = '',
  $uidmin   = '',
  $uidmax   = '',
) {

  file { "/etc/webmin/cron/${user}.acl":
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0640',
    content => template('webmin/module/cron.erb'),
    require => Package['webmin'],
    notify  => Service['webmin'],
  }

}
