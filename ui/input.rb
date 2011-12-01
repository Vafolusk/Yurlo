require 'rubygems'
require "termios"

module UI
  class Input
    attr_accessor :handlers

    def shutdown
      Termios.setattr(STDIN, Termios::TCSANOW, @original_settings)
    end

    def initialize
      @handlers = {}
      settings = Termios.getattr(STDIN)
      @original_settings = settings.dup
      settings.c_lflag&= ~(Termios::ECHO | Termios::ICANON)
      settings.c_cc[Termios::VMIN] = 1
      Termios.setattr(STDIN, Termios::TCSANOW, settings)
    end

    def process_key c
      k = c.chr
      if @handlers.has_key? k
        @handlers[k].call
      end
    end


    def process
      process_key STDIN.getbyte
    end

    def get_string
      s = gets
      process_string
    end
  end
end
