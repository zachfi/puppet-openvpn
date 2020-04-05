require 'spec_helper'

describe 'openvpn::disable' do
  shared_examples_for 'openvpn disable' do
    it { is_expected.to compile.with_all_deps }

    it {
      is_expected.to contain_service('openvpn')
        .with_ensure('stopped')
        .with_enabled(false)
    }
    it {
      is_expected.to contain_package('openvpn')
        .with_ensure('absent')
    }
  end

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      it_behaves_like 'openvpn disable'
    end
  end
end
