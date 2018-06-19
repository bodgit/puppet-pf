require 'spec_helper'

describe 'pf::authpf::user' do

  let(:pre_condition) do
    'include ::pf::authpf'
  end

  let(:title) do
    'test'
  end

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts.merge({
          :concat_basedir => '/tmp',
        })
      end

      it { is_expected.to compile.and_raise_error(%r{At least one of \$message or \$rules should be specified\.}) }

      context 'with parameters' do

        let(:params) do
          {
            message: '',
            rules:   '',
          }
        end

        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_pf__authpf__user('test') }
        it { is_expected.to contain_file('/etc/authpf/users/test') }
        it { is_expected.to contain_file('/etc/authpf/users/test/authpf.message').with_content('') }
        it { is_expected.to contain_file('/etc/authpf/users/test/authpf.rules').with_content('') }
      end
    end
  end
end
