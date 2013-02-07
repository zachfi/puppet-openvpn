# Class: openvpn::params
#
# Set some OS specific params for OpenVPN
#
class openvpn::params {

  case $::operatingsystem {
    'freebsd': {
      $openvpn_dir  = '/usr/local/etc/openvpn'
      $package_name = 'security/openvpn'
      $openssl      = '/usr/bin/openssl'
    }
    'openbsd': {
      $openvpn_dir  = '/etc/openvpn'
      $package_name = 'openvpn'
      $openssl      = '/usr/sbin/openssl'
    }
    default: {
      $openvpn_dir  = '/etc/openvpn'
      $package_name = 'openvpn'
      $openssl      = '/usr/bin/openssl'
    }
  }

  $ccd = 'ccd'
}
