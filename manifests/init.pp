class openvpn {
  include openvpn::params

  $openvpn_dir = $openvpn::params::openvpn_dir

  package { "openvpn": ensure => installed; }
  service { "openvpn": ensure => running, enable => true; }

  file { "$openvpn_dir": ensure => directory; }

}

