# Define: webmin::module::acl::file
#
# This definition creates a new ACL configuration for FILE module
#
# Parameters:
#   [*user*]            - Name of the user that will have following privileges.
# Privileges:
#   [*noconfig*]        - Edit this webmin's module configuration (0|1)
#   [*contents*]        - Allow searching of file contents
#   [*max*]             - Maximum upload size
#   [*ro*]              - Read-only mode
#   [*chroot*]          - Chroot directory for entire file manager
#   [*uid*]             - Access files on server as user
#   [*dostounix*]       - Can have Windows newlines converted
#   [*unarchive*]       - Can extract uploaded archive files
#   [*filesystems*]     - Can see filesystem mount points
#   [*follow*]          - Always follow symlinks
#   [*noperms*]         - Can change file permissions
#   [*nousers*]         - Can change file ownership
#   [*goto*]            - Open first allowed directory
#   [*root*]            - Only allow access to directories
#   [*noroot*]          - Deny access to directories
#   [*home*]            - ?
#   [*archive*]         - Can download archives of directories
#   [*archmax*]         - Can download archives of directories (if smaller than VALUE bytes)
#   [*umask*]           - Umask for new files
#   [*button_new*]      - New (create text file)
#   [*button_acl*]      - ACL (edit Posix ACL)
#   [*button_copy*]     - Copy, Cut and Paste
#   [*button_preview*]  - Preview (view scaled-down image)
#   [*button_search*]   - Find (find files)
#   [*button_mkdir*]    - New (create directory)
#   [*button_save*]     - Save (download file)
#   [*button_attr*]     - Attr (edit XFS attributes)
#   [*button_delete*]   - Delete (delete files)
#   [*button_rename*]   - Rename (rename file)
#   [*button_edit*]     - Edit (edit text file)
#   [*button_mount*]    - Mount (mount or un-mount filesystem)
#   [*button_upload*]   - Upload (upload file from client, or extract on server)
#   [*button_sharing*]  - Sharing (setup Samba and NFS file sharing)
#   [*button_makelink*] - New (create symbolic link)
#   [*button_info*]     - Info (edit file permissions and ownership)
#   [*button_ext*]      - EXT (edit EXT attributes)
#
# Actions:
#
# Requires:
#
# Sample Usage:
#  webmin::module::acl::file { 'jsosic': }
define webmin::module::acl::file (
  $user            = $title,
  $noconfig        = '1',
  $contents        = '1',
  $max             = '',
  $ro              = '0',
  $chroot          = '/',
  $uid             = '-1',
  $dostounix       = '1',
  $unarchive       = '1',
  $filesystems     = '1',
  $follow          = '0',
  $noperms         = '0',
  $nousers         = '0',
  $goto            = '1',
  $root            = '/',
  $noroot          = '',
  $home            = '',
  $archive         = '1',
  $umask           = '022',
  $archmax         = '',
  $button_new      = 'on',
  $button_acl      = 'on',
  $button_copy     = 'on',
  $button_preview  = 'on',
  $button_search   = 'on',
  $button_mkdir    = 'on',
  $button_save     = 'on',
  $button_attr     = 'on',
  $button_delete   = 'on',
  $button_rename   = 'on',
  $button_edit     = 'on',
  $button_mount    = 'on',
  $button_upload   = 'on',
  $button_sharing  = 'on',
  $button_makelink = 'on',
  $button_info     = 'on',
  $button_ext      = 'on',
) {

  file { "/etc/webmin/file/${user}.acl":
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0640',
    content => template('webmin/module/file.erb'),
    require => Package['webmin'],
    notify  => Service['webmin'],
  }

}
