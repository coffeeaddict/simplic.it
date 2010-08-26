class ToolsController < ApplicationController

  def index
  end

  def pwgen
    @@generator ||= PassphraseGenerator.new
    @phrases = []

    10.times do 
      @phrases << @@generator.get_passphrase
    end
  end

  def wsdl
  end

  def wsdl_analyze
    contents = nil
    if params[:url]
      # load the contents from uri
    elsif params[:file
      # load the contents from file
    else
      # err
      raise "No Wisdel, no glory!"
    end

    hash = HashWithIndifferentAccess.from_xml(contents)
  end
end
