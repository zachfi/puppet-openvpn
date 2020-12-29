# CLass: openvpn::disable
#
# Disable and remove OpenVPN
#
class openvpn::disable {
  Service['openvpn'] -> Package['openvpn']

  service { 'openvpn':
    ensure => stopped,
    enable => false,
  }
  package { 'openvpn':
    ensure => absent,
  }
}
