require 'spec_helper_acceptance'

describe 'pf' do

  pp = <<-EOS
    class { '::pf':
      source => '/etc/examples/pf.conf',
    }
  EOS

  case fact('osfamily')
  when 'OpenBSD'
    it 'should work with no errors' do
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
    end

    describe file('/etc/pf.conf') do
      it { is_expected.to be_file }
      it { is_expected.to be_mode 600 }
      it { is_expected.to be_owned_by 'root' }
      it { is_expected.to be_grouped_into 'wheel' }
      its(:size) { is_expected.to be > 0 }
    end
  else
    it 'should not work' do
      apply_manifest(pp, :expect_failures => true)
    end
  end
end
