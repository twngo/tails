require 'java'
require 'rubygems'

Before do |scenario|
  new_tails_instance
  @screen = Sikuli::Screen.new
  @sniffer = Sniffer.new("TestSniffer", @vm.net.bridge_name, @vm.ip, @vm.ip6)
  @sniffer.capture
  @feature = File.basename(scenario.feature.file, ".feature")
  @background_snapshot = "#{Dir.pwd}/features/tmpfs/#{@feature}_background.state"
  @skip_steps_while_restoring_background = false
  @theme = "gnome"
end


After do |scenario|
  if (scenario.status != :passed)
    @vm.take_screenshot("#{@feature}-#{DateTime.now}")
  end
  @sniffer.stop
  @vm.stop
end
