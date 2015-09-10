class Firmware
  include ActiveModel::Model
  attr_accessor :manufacturer_name
  attr_accessor :device_name
  attr_accessor :arduino_model

  validates :manufacturer_name, presence: true
  validates :device_name, presence: true
  validates :arduino_model, presence: true

  def self.arduino_models
    %w(uno mega)
  end
  validates :arduino_model, inclusion: { in: self.arduino_models,
    message: "%{value} is not a valid arduino_model" }

  def generate_code
    FirmwareCreationJob.perform_later(self.manufacturer_name, self.device_name, self.arduino_model)
    # Descriptors
    # dir_path = File.join(Rails.root, 'app/assets/LUFA-140928/Projects/hiduino-master/src/arduino_midi')
    # original_file_path = File.join(dir_path, 'Descriptors_original.c')
    # content = File.read(original_file_path)
    # new_content = content.gsub(/{{PRODUCT_STRING}}/, self.device_name)
    # new_content = new_content.gsub(/{{MANUFACTURER_STRING}}/, self.manufacturer_name)
    # new_file_path = File.join(dir_path, 'Descriptors.c')
    # File.open(new_file_path, "w") {|file| file.puts new_content }

    # Makefile
    # dir_path = File.join(Rails.root, 'app/assets/LUFA-140928/Projects/hiduino-master/src/arduino_midi')
    # original_file_path = File.join(dir_path, 'makefile_original')
    # content = File.read(original_file_path)
    # new_content = content.gsub(/{{ARDUINO_MODEL_PID}}/, self.arduino_model)
    # new_file_path = File.join(dir_path, 'makefile')
    # File.open(new_file_path, "w") {|file| file.puts new_content }
  end
end
