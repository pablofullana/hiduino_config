class FirmwaresController < ApplicationController
  def new
    @arduino_models = Firmware.arduino_models
  end

  def create
  end
end
