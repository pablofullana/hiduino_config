class FirmwareCreationJob < ActiveJob::Base
  queue_as :default

  def perform(device_name, manufacturer_name, arduino_model)
    puts "Will do some magic for '#{device_name}' from '#{manufacturer_name}' for a Arduino '#{arduino_model}'"
    sleep(5)
  end
end
