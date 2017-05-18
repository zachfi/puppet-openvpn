# Define: openvpn::client
#
# Configure an OpenVPN client instance
#
define openvpn::client (
  $server,
  $auth           = 'SHA1',
  $port           = '1194',
  $proto          = 'udp',
  $dev            = 'tun',
  $ca             = 'ca.crt',
  $cert           = $name,
  $ns_cert_type   = 'server',
  $verb           = 3,
  $cipher         = 'AES-192-CBC',
  $compression    = 'lzo',
  $tls_auth_key   = undef,
  $custom_options = [],
) {

  include ::openvpn
  $openvpn_dir         = $::openvpn::openvpn_dir
  $openvpn_group       = $::openvpn::openvpn_group
  $openvpn_user        = $::openvpn::openvpn_user
  $openssl             = $::openvpn::openssl

  file { "${openvpn_dir}/${server}.conf":
    owner   => root,
    group   => 0,
    mode    => '0640',
    content => template('openvpn/client.conf.erb'),
  }

  if $openvpn::manage_service {
    File["${openvpn_dir}/${server}.conf"]
    ~> Service['openvpn']

    if $openvpn::manage_systemd_unit {
      service { "openvpn@${server}":
        ensure  => running,
        enable  => true,
        require => File[$openvpn_dir],
      }

      File["${openvpn_dir}/${server}.conf"]
      ~> Service["openvpn@${server}"]
    }
  }
}
