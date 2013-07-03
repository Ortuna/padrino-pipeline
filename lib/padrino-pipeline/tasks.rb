require 'padrino-core/tasks'
##
# Allows tasks to be added to the client Padrino application
if defined? Padrino::Tasks
  Padrino::Tasks.files.concat(Dir["#{File.dirname(__FILE__)}/tasks/**/*.rb"])
end
