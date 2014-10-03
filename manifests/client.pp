# Define: openvpn::client
#
# Configure an OpenVPN client instance
#
define openvpn::client (
  $server,
  $port  = '1194',
  $proto = 'udp',
  $dev   = 'tun',
  $ca    = 'ca.crt',
  $cert  = $name
) {

  include openvpn

  file { "/etc/openvpn/${server}.conf":
    owner   => root,
    group   => 0,
    mode    => '0640',
    content => template('openvpn/client.conf.erb'),
    notify  => Service['openvpn'],
  }
}
