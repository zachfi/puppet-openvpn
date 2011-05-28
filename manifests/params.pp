class openvpn::params {

  case $operatingsystem {
    'freebsd': {
      $openvpn_dir = '/usr/local/etc/openvpn',

    }
    default: {

    }

}

