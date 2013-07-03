namespace :pipeline do

  desc "Compile javascript assets"
  task :compile_js do
    require File.expand_path('config/boot.rb', Rake.application.original_dir)
    Padrino.mounted_apps.each do |mounted_app|
      app = mounted_app.app_obj
      app.pipeline.compile(:js) if app.pipeline?
    end
  end

  desc "Compile CSS assets"
  task :compile_css do
    require File.expand_path('config/boot.rb', Rake.application.original_dir)
    Padrino.mounted_apps.each do |mounted_app|
      app = mounted_app.app_obj
      app.pipeline.compile(:css) if app.pipeline?
    end
  end
end
