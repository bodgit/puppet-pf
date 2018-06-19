require 'spec_helper'

describe 'pf::authpf::allow' do

  let(:pre_condition) do
    'include ::pf::authpf'
  end

  let(:title) do
    '*'
  end

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts.merge({
          :concat_basedir => '/tmp',
        })
      end

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_pf__authpf__allow('*') }
      it { is_expected.to contain_concat('/etc/authpf/authpf.allow') }
      it { is_expected.to contain_concat__fragment('/etc/authpf/authpf.allow *').with_content("*\n") }
    end
  end
end
