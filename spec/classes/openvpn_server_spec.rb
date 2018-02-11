require 'spec_helper'

describe 'openvpn::server' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      it { is_expected.to contain_class('openvpn::server') }
      it { is_expected.to contain_exec('create dh2048.pem') }

      case facts[:osfamily]
      when 'FreeBSD'
        it { is_expected.to contain_file('/usr/local/etc/openvpn/openvpn.conf') }
      else
        it { is_expected.to contain_file('/etc/openvpn/openvpn.conf') }
      end
    end
  end
end
