class openvpn {
  include openvpn::params

  $openvpn_dir = $openvpn::params::openvpn_dir
  $package     = $openvpn::params::package

  package { $package: ensure => installed; }
  #service { "openvpn": ensure => running, enable => true; }

  file { $openvpn_dir: ensure => directory; }

}

