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

  case $::lsbdistcodename {
    'xenial', 'jessie': {
      # On Ubuntu Xenial and Debian Jessie, starting the 'openvpn' service doesn't connect a client
      # the 'openvpn@<connection name>' service needs to be started, where <connection name> is
      # the name of the config file in /etc/openvpn, minus the .conf extension.
      $manage_systemd_unit = true
    }
    default: {
      $manage_systemd_unit = false
    }
  }

  $ccd = 'ccd'
}
