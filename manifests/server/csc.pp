# CSC: Client specific configuration
define openvpn::server::csc (
  String           $filename                   = $title,
  Optional[String] $content                    = undef,
  String           $owner                      = 'root',
  Integer          $group                      = 0,
  String           $mode                       = '0640',
  Optional[String] $ifconfig_push              = undef,
  String           $ifconfig_push_netmask      = '255.255.255.0',
  Optional[String] $ifconfig_ipv6_push         = undef,
  String           $ifconfig_ipv6_push_netmask = '',
) {


  include openvpn::server
  $ccd_dir = $openvpn::server::ccd_dir

  realize(File[$ccd_dir])

  file { "${ccd_dir}/${filename}":
    owner   => $owner,
    group   => $group,
    mode    => $mode,
    content => template('openvpn/csc.erb'),
  }
}
