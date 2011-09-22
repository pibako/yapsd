package :build_essential do
  description 'Build tools and utility tools'

  apt 'build-essential' do
    pre :install, 'apt-get update'
    pre :install, 'apt-get upgrade'
  end

  verify do
    has_apt 'build-essential'
  end

end
