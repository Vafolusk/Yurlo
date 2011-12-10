class ScrollingText

  def initialize(template_name)
    @template_name = template_name
  end

  def begin window
    tr = TemplateRenderer.new
    lines_to_skip = 0 
    line_count_total = 0
    line_count = 0
    cancel = false
    window.timeout 0

    begin 
      skipped = 0
      window.clear
      window.move 0, 0
      line_count = 0
      tr.render(window, @template_name) do |window, ch|
        if line_count > lines_to_skip
          window.addstr ch
          window.refresh
        end

        if ch == "\n"
          line_count += 1
        end
      end

      lines_to_skip += 1
      line_count_total ||= line_count
      sleep 1
      break if window.getch == 32
    end while lines_to_skip < line_count 
    window.timeout -1
  end
end
