# CLass: openvpn::disable
#
# Disable and remove OpenVPN
#
class openvpn::disable {

  service { 'openvpn': ensure => stopped, enable => false; }->
  package { 'openvpn': ensure => absent; }
}
