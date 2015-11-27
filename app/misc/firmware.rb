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

  def arduino_model_pid(arduino_model)
    case self.arduino_model
    when 'uno'
      arduino_model_pid = '0x0001'
    when 'mega'
      arduino_model_pid = '0x0010'
    else
      arduino_model_pid = '0x0000'
    end

    return arduino_model_pid
  end

  def generate_hex_file
    firmware_path = File.join(Rails.root, 'tmp', 'firmwares', SecureRandom.uuid)
    FileUtils.mkdir_p firmware_path
    FileUtils.cp_r File.join(Rails.root, 'lib', 'assets', 'hiduino-master') ,firmware_path

    project_directory_path = File.join(firmware_path, 'hiduino-master', 'LUFA-140928', 'Projects', 'arduino_midi')    

    # Descriptors
    descriptors_file_path = File.join(project_directory_path, 'Descriptors.c')
    content = File.read(descriptors_file_path)
    new_content = content.gsub(/{{PRODUCT_STRING}}/, self.device_name)
    new_content = new_content.gsub(/{{MANUFACTURER_STRING}}/, self.manufacturer_name)
    File.open(descriptors_file_path, "w") { |file| file.puts new_content }

    # Makefile
    make_file_path = File.join(project_directory_path, 'makefile')
    content = File.read(make_file_path)
    new_content = content.gsub(/{{ARDUINO_MODEL_PID}}/, self.arduino_model_pid(self.arduino_model))
    File.open(make_file_path, "w") {|file| file.puts new_content }

    # Make
    system "make -C #{project_directory_path}"
    hex_file_content = File.read File.join(project_directory_path, 'arduino_midi.hex')

    # Cleanup
    FileUtils.rm_rf firmware_path

    return hex_file_content
  end
end
