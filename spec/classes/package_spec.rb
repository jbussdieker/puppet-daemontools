require 'spec_helper'

describe 'daemontools::package' do
  it { should contain_package('daemontools') }
  it { should contain_package('daemontools-run') }
end
