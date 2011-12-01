module Term
  class Stdout < File
    attr_accessor :capture_buffer

    def initialize(stdout)
      @stdout = stdout
      @capture = false
      @capture_buffer = ''
    end

    def begin_capture
      @capture = true
      @capture_buffer = ''
    end

    def end_capture
      @capture = false
    end

    def write(s)
      if @capture 
        @capture_buffer += s 
        @capture_buffer.length
      else 
        @stdout.write(s) 
      end
    end
  end
end
