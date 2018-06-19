require 'spec_helper'

describe 'pf::authpf::ban' do

  let(:pre_condition) do
    'include ::pf::authpf'
  end

  let(:title) do
    'test'
  end

  let(:params) do
    {
      content: '',
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

      it { is_expected.to contain_pf__authpf__ban('test') }
      it { is_expected.to contain_file('/etc/authpf/banned/test').with_content('') }
    end
  end
end
