# Class: openvpn::params
#
# Set some OS specific params for OpenVPN
#
class openvpn::params {

  case $::operatingsystem {
    'freebsd': {
      $openvpn_dir  = '/usr/local/etc/openvpn'
      $package_name = 'security/openvpn'
    }
    default: {
      $openvpn_dir  = '/etc/openvpn'
      $package_name = 'openvpn'
    }
  }

  $ccd = 'ccd'
}
