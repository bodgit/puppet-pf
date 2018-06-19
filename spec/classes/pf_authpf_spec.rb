require 'spec_helper'

describe 'pf::authpf' do

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts.merge({
          :concat_basedir => '/tmp',
        })
      end

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_class('pf::authpf') }
      it { is_expected.to contain_class('pf::authpf::config') }
      it { is_expected.not_to contain_concat('/etc/authpf/authpf.allow') }
      it { is_expected.to contain_file('/etc/authpf') }
      it { is_expected.to contain_file('/etc/authpf/authpf.conf') }
      it { is_expected.to contain_file('/etc/authpf/banned') }
      it { is_expected.to contain_file('/etc/authpf/users') }
    end
  end
end
