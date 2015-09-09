class FirmwaresController < ApplicationController
  def new
    @arduino_models = Firmware.arduino_models
  end

  def create
  end


  private
  def firmware_params
    params.require(:firmware).permit(:manufacturer_name, :device_name, :arduino_model)
  end

end
