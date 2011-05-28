class openvpn::disable {

  package { "openvpn": ensure => absent; }
  service { "openvpn": ensure => stopped, enable => false; }

}

