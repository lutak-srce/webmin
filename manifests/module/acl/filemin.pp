#
# = Define: webmin::module::acl::filemin
#
# This definition creates a new ACL configuration for FILE module
#
# Parameters:
#   [*user*]             - Name of the user that will have following privileges.
# Privileges:
#   [*noconfig*]         - Edit this webmin's module configuration (0|1)
#   [*allowed_paths*]    - Allow access to directories
#   [*allowed_for_edit*] - Mimetypes allowed for edit by builtin editor
#   [*work_as_user*]     - Specific unix user
#   [*work_as_root*]     - Allow working as root
#   [*max*]              - Maximum upload size
#
# Actions:
#
# Requires:
#
# Sample Usage:
#  webmin::module::acl::filemin { 'jsosic': }
define webmin::module::acl::filemin (
  $user             = $title,
  $noconfig         = '1',
  $allowed_paths    = '$HOME',
  $allowed_for_edit = 'application-x-php application-x-ruby application-xml application-javascript application-x-shellscript application-x-perl application-x-yaml',
  $work_as_user     = '',
  $work_as_root     = '0',
  $max              = '',
) {

  file { "/etc/webmin/filemin/${user}.acl":
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0640',
    content => template('webmin/module/filemin.erb'),
    require => Package['webmin'],
    notify  => Service['webmin'],
  }

}
