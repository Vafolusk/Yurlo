
Dir[File.dirname(__FILE__) + "/app/*.rb"].each { |file| require file } 

Dir[File.dirname(__FILE__) + "/app/pages/*.rb"].each { |file| require file } 
Dir[File.dirname(__FILE__) + "/app/ui/*.rb"].each { |file| require file } 
