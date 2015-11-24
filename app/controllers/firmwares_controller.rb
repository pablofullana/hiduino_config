class FirmwaresController < ApplicationController
  def new
    @arduino_models = Firmware.arduino_models
  end

  def create
    firmware = Firmware.new firmware_params
  
    send_data firmware.generate_hex_file
  end


  private
  def firmware_params
    params.require(:firmware).permit(:manufacturer_name, :device_name, :arduino_model)
  end

end
