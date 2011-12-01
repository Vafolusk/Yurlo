module UI
  class TypingText
    include Term
    def initialize(template_name)
      tr = TemplateRenderer.new
      @text = tr.eval template_name
      @multiline = true
    end

    def begin
      lines = @text.split "\n"
      lines.each do |line|
        line.chars.each do |char|
          printf char
          STDOUT.flush
          sleep 0.05
        end
        if !@multiline
          sleep 3
          cursor_back 1
          line.size.times do
            printf ' '
            STDOUT.flush
            cursor_back 2
            sleep 0.005
          end
        else
          puts
        end
      end
    end
  end
end

