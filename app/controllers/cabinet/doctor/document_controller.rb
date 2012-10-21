class Cabinet::Doctor::DocumentController < ApplicationController
  def new
    @document = Document.new
  end
end
