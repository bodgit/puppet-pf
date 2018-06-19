require 'spec_helper_acceptance'

describe 'pf::authpf' do

  pp = <<-EOS
    class { '::pf':
      source => '/etc/examples/pf.conf',
    }

    class { '::pf::authpf':
      rules   => @(EOS/L),
        pass in proto tcp from $user_ip to any port { 80, 443 }
        | EOS
      message => @(EOS/L),
        You are being watched, play nice.
        | EOS
      problem => @(EOS/L),
        Try turning it off and on again.
        | EOS
    }

    ::pf::authpf::allow { '*': }

    ::pf::authpf::ban { 'alice':
      content => @(EOS/L),
        You have been naughty!
        | EOS
    }

    ::pf::authpf::user { 'bob':
      rules   => @(EOS/L),
        pass in from $user_ip to any
        | EOS
      message => @(EOS/L),
        You have super powers.
        | EOS
    }
  EOS

  case fact('osfamily')
  when 'OpenBSD'
    it 'should work with no errors' do
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
    end

    describe file('/etc/authpf') do
      it { is_expected.to be_directory }
      it { is_expected.to be_mode 755 }
      it { is_expected.to be_owned_by 'root' }
      it { is_expected.to be_grouped_into 'wheel' }
    end

    describe file('/etc/authpf/authpf.conf') do
      it { is_expected.to be_file }
      it { is_expected.to be_mode 644 }
      it { is_expected.to be_owned_by 'root' }
      it { is_expected.to be_grouped_into 'wheel' }
      its(:size) { is_expected.to eq 0 }
    end

    describe file('/etc/authpf/authpf.allow') do
      it { is_expected.to be_file }
      it { is_expected.to be_mode 644 }
      it { is_expected.to be_owned_by 'root' }
      it { is_expected.to be_grouped_into 'wheel' }
      its(:content) { is_expected.to eq "*\n" }
    end

    describe file('/etc/authpf/authpf.message') do
      it { is_expected.to be_file }
      it { is_expected.to be_mode 644 }
      it { is_expected.to be_owned_by 'root' }
      it { is_expected.to be_grouped_into 'wheel' }
      its(:content) { is_expected.to eq "You are being watched, play nice.\n" }
    end

    describe file('/etc/authpf/authpf.problem') do
      it { is_expected.to be_file }
      it { is_expected.to be_mode 644 }
      it { is_expected.to be_owned_by 'root' }
      it { is_expected.to be_grouped_into 'wheel' }
      its(:content) { is_expected.to eq "Try turning it off and on again.\n" }
    end

    describe file('/etc/authpf/authpf.rules') do
      it { is_expected.to be_file }
      it { is_expected.to be_mode 644 }
      it { is_expected.to be_owned_by 'root' }
      it { is_expected.to be_grouped_into 'wheel' }
      its(:content) { is_expected.to eq "pass in proto tcp from $user_ip to any port { 80, 443 }\n" }
    end

    describe file('/etc/authpf/banned') do
      it { is_expected.to be_directory }
      it { is_expected.to be_mode 755 }
      it { is_expected.to be_owned_by 'root' }
      it { is_expected.to be_grouped_into 'wheel' }
    end

    describe file('/etc/authpf/banned/alice') do
      it { is_expected.to be_file }
      it { is_expected.to be_mode 644 }
      it { is_expected.to be_owned_by 'root' }
      it { is_expected.to be_grouped_into 'wheel' }
      its(:content) { is_expected.to eq "You have been naughty!\n" }
    end

    describe file('/etc/authpf/users') do
      it { is_expected.to be_directory }
      it { is_expected.to be_mode 755 }
      it { is_expected.to be_owned_by 'root' }
      it { is_expected.to be_grouped_into 'wheel' }
    end

    describe file('/etc/authpf/users/bob') do
      it { is_expected.to be_directory }
      it { is_expected.to be_mode 755 }
      it { is_expected.to be_owned_by 'root' }
      it { is_expected.to be_grouped_into 'wheel' }
    end

    describe file('/etc/authpf/users/bob/authpf.message') do
      it { is_expected.to be_file }
      it { is_expected.to be_mode 644 }
      it { is_expected.to be_owned_by 'root' }
      it { is_expected.to be_grouped_into 'wheel' }
      its(:content) { is_expected.to eq "You have super powers.\n" }
    end

    describe file('/etc/authpf/users/bob/authpf.rules') do
      it { is_expected.to be_file }
      it { is_expected.to be_mode 644 }
      it { is_expected.to be_owned_by 'root' }
      it { is_expected.to be_grouped_into 'wheel' }
      its(:content) { is_expected.to eq "pass in from $user_ip to any\n" }
    end
  else
    it 'should not work' do
      apply_manifest(pp, :expect_failures => true)
    end
  end
end
