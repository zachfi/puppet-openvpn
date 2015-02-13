# Class: openvpn::params
#
# Set some OS specific params for OpenVPN
#
class openvpn::params {

  case $::operatingsystem {
    'freebsd': {
      $openvpn_dir    = '/usr/local/etc/openvpn'
      $package_name   = 'security/openvpn'
      $manage_service = true
      $openvpn_user    = undef
      $openvpn_group   = undef
    }
    'OpenBSD': {
      $openvpn_dir    = '/etc/openvpn'
      $package_name   = 'openvpn'
      $manage_service = false
      $openvpn_user   = '_openvpn'
      $openvpn_group  = '_openvpn'
    }
    default: {
      $openvpn_dir    = '/etc/openvpn'
      $package_name   = 'openvpn'
      $manage_service = true
      $openvpn_user   = 'nobody'
      $openvpn_group  = 'nobody'
    }
  }

  $ccd = 'ccd'
}
