require 'spec_helper'

describe 'openvpn::client' do
  let(:title) { 'one' }
  let(:params) { { server: 'vpn.example.com' } }

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }
      it { is_expected.to contain_class('openvpn') }

      case facts[:osfamily]
      when 'FreeBSD'
        it { is_expected.to contain_file('/usr/local/etc/openvpn/vpn.example.com.conf') }
      else
        it { is_expected.to contain_file('/etc/openvpn/vpn.example.com.conf') }
      end

      case facts[:kernel]
      when 'Linux'
        it { is_expected.to contain_service('openvpn@vpn.example.com') }
      else
        it { is_expected.not_to contain_service('openvpn@vpn.example.com') }
      end
    end
  end
end
