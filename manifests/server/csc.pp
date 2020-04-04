# CSC: Client specific configuration
define openvpn::server::csc (
  Optional[String] $content = undef,
  String           $owner   = 'root',
  Integer          $group   = 0,
  String           $mode    = '0640',
) {

  include openvpn
  $openvpn_dir = $openvpn::openvpn_dir

  realize(File["${openvpn_dir}/ccd"])

  file { "${openvpn_dir}/${openvpn::server::ccd}/${name}":
    owner   => $owner,
    group   => $group,
    mode    => $mode,
    content => $content,
  }
}
