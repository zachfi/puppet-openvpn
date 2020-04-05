require 'spec_helper'

describe 'openvpn' do
  shared_examples_for 'openvpn' do
    it { is_expected.to compile.with_all_deps }

    it { is_expected.to contain_class('openvpn') }
  end

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      it_behaves_like 'openvpn'

      case facts[:osfamily]
      when 'FreeBSD'
        it { is_expected.to contain_file('/usr/local/etc/openvpn') }
        it { is_expected.to contain_package('security/openvpn') }
      else
        it { is_expected.to contain_file('/etc/openvpn') }
        it { is_expected.to contain_package('openvpn') }
      end

      case facts[:osfamily]
      when 'OpenBSD'
        it { is_expected.not_to contain_service('openvpn') }
      else
        it { is_expected.to contain_service('openvpn') }
      end
    end
  end
end
