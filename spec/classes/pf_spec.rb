require 'spec_helper'

describe 'pf' do

  let(:params) do
    {
      source: '/etc/examples/pf.conf',
    }
  end

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts.merge({
          :concat_basedir => '/tmp',
        })
      end

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_class('pf') }
      it { is_expected.to contain_class('pf::config') }
      it { is_expected.to contain_class('pf::params') }
      it { is_expected.to contain_exec('/sbin/pfctl -f /etc/pf.conf') }
      it { is_expected.to contain_file('/etc/pf.conf') }
    end
  end
end
