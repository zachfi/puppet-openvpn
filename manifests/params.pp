# Class: openvpn::params
#
# Set some OS specific params for OpenVPN
#
class openvpn::params {

  case $::operatingsystem {
    'FreeBSD': {
      $openvpn_dir    = '/usr/local/etc/openvpn'
      $package_name   = 'security/openvpn'
      $manage_service = true
      $openvpn_user   = undef
      $openvpn_group  = undef
      $openssl        = '/usr/bin/openssl'
    }
    'OpenBSD': {
      $openvpn_dir    = '/etc/openvpn'
      $package_name   = 'openvpn'
      $manage_service = false
      $openvpn_user   = '_openvpn'
      $openvpn_group  = '_openvpn'
      if ( versioncmp($::kernelversion, '5.7') < 0 ) {
        $openssl = '/usr/sbin/openssl'
      } else {
        $openssl ='/usr/bin/openssl'
      }
    }
    default: {
      $openvpn_dir    = '/etc/openvpn'
      $package_name   = 'openvpn'
      $manage_service = true
      $openvpn_user   = 'nobody'
      $openvpn_group  = 'nobody'
      $openssl        = '/usr/bin/openssl'
    }
  }

  $ccd = 'ccd'
}
