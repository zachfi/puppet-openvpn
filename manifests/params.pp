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
    }
    'openbsd': {
      $openvpn_dir    = '/usr/local/etc/openvpn'
      $package_name   = 'security/openvpn'
      $manage_service = false
    }
    default: {
      $openvpn_dir    = '/etc/openvpn'
      $package_name   = 'openvpn'
      $manage_service = true
    }
  }

  $ccd = 'ccd'
}
