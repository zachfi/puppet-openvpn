# Class: openvpn::server
#
# Install and configure the OpenVPN server
#
class openvpn::server (
  Optional[String]        $local_ip                 = undef,
  String                  $auth                     = 'SHA1',
  String                  $ca                       = 'ca.crt',
  String                  $cert                     = 'server.crt',
  Optional[String]        $cipher                   = undef,
  String                  $client_cert_not_required = '',
  Boolean                 $client_to_client         = false,
  Optional[String]        $crl                      = undef,
  String                  $dev                      = 'tun',
  String                  $dev_type                 = '',
  String                  $dh                       = 'dh2048.pem',
  Integer                 $dh_size                  = 2048,
  Variant[String,Array]   $dns                      = '',
  Variant[String,Array]   $domain                   = '',
  String                  $wins                     = '',
  String                  $duplicate_cn             = '',
  String                  $ifconfig                 = '',
  String                  $key                      = 'server.key',
  String                  $log                      = '',
  String                  $log_append               = '',
  String                  $status_log               = 'openvpn-status.log',
  Variant[String,Array]   $plugins                  = '',
  String                  $verb                     = '3',
  String                  $port                     = '1194',
  String                  $proto                    = 'udp',
  String                  $redirect_gateway         = '',
  Array                   $route                    = [],
  Array                   $route_ipv6               = [],
  String                  $server                   = '10.8.0.0 255.255.255.0',
  String                  $ipp                      = 'ipp.txt',
  Optional[String]        $server_ipv6              = undef,
  String                  $username_as_common_name  = '',
  Variant[String,Integer] $script_security          = '',
  String                  $client_connect           = '',
  String                  $client_disconnect        = '',
  Boolean                 $tls_auth                 = false,
  String                  $tls_verify               = '',
  String                  $topology                 = 'subnet',
  Array                   $custom_options           = [],
  String                  $ccd                      = 'ccd',
  Boolean                 $purge_ccd                = false,
  String                  $compress                 = 'legacy',
  String                  $keepalive                = '10 120',
  String                  $learn_address            = '',
  Optional[String]        $management               = undef,
) {

  include openvpn
  $openvpn_dir   = $openvpn::openvpn_dir
  $openvpn_path  = $openvpn::openvpn_path
  $openvpn_group = $openvpn::openvpn_group
  $openvpn_user  = $openvpn::openvpn_user
  $openssl       = $openvpn::openssl

  if ( $log_append != '' ) and ( $log != '' ){
    err('Log_append and log should not both be defined')
  }

  $ccd_dir = $ccd ? {
      /^\/.*/ => $ccd,
      default => "${openvpn_dir}/${ccd}",
  }
  @file { $ccd_dir:
    ensure  => directory,
    owner   => 'root',
    group   => 0,
    mode    => '0755',
    purge   => $purge_ccd,
    recurse => $purge_ccd,
  }

  # Server configuration file
  #file { "${openvpn_dir}/${name}.conf":
  file { "${openvpn_dir}/openvpn.conf":
    owner   => 'root',
    group   => 0,
    mode    => '0600',
    content => template('openvpn/server.conf.erb'),
    tag     => 'openvpn',
  }

  $fq_dh = $dh ? {
      /^\/.*/ => $dh,
      default => "${openvpn_dir}/${dh}",
  }
  exec { "create ${dh}":
    cwd     => $openvpn_dir,
    command => "${openssl} dhparam -out ${fq_dh} ${dh_size}",
    creates => $fq_dh,
    tag     => 'openvpn',
  }

  if $tls_auth {
    exec { 'create tls_auth key':
      cwd     => $openvpn_dir,
      command => "${openvpn_path} --genkey --secret ta.key",
      creates => "${openvpn_dir}/ta.key",
      tag     => 'openvpn',
    }
  }
}
