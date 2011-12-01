require 'rubygems'
require 'term/ansi' 
require 'ui/transition'
require 'ui/template_renderer'
require 'ui/input'
require 'ui/arrow'
require 'ui/scrolling_text'
require 'ui/typing_text'

def quit
  exit
end

def forever
  while true 
    yield
  end
end

$tr = UI::TemplateRenderer.new

def help
  trans = UI::Transition.new
  trans.falling_curtain
  trans.rising_curtain
  $tr.render 'help'
  UI::Arrow.down_arrow 10, 15 
  UI::Arrow.up_arrow 20, 15 
  UI::Arrow.right_arrow 30, 15 
  UI::Arrow.left_arrow 40, 15 
end

def background
  #st = UI::ScrollingText.new 'background'
  st = UI::TypingText.new 'background'
  st.begin
  sleep 10
end

def title
  $tr.render 'title'
end

$input = UI::Input.new

$input.handlers['q'] = method(:quit)
$input.handlers['h'] = method(:help)
$input.handlers['B'] = method(:background)

trans = UI::Transition.new
trans.falling_curtain
trans.rising_curtain
title
sleep 3
trans.noise
background
sleep 3
help

forever do
  $input.process
end

Term::set_display_attributes [Term::RESET]
