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
end
