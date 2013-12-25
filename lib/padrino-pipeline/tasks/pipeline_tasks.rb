namespace :pipeline do
  def load_apps
    require File.expand_path('config/boot.rb', Rake.application.original_dir)
  end

  def send_to_pipeline(method, *args) 
    Padrino.mounted_apps.each do |mounted_app|
      app = mounted_app.app_obj
      app.pipeline.send(method, *args) if app.pipeline?
    end
  end

  desc "Compile all assets"
  task :compile => [:compile_js, :compile_css]

  desc "Clean all assets"
  task :clean => [:clean_js, :clean_css]

  desc "Compile javascript assets"
  task :compile_js do
    load_apps
    send_to_pipeline(:compile, :js)
  end

  desc "Compile CSS assets"
  task :compile_css do
    load_apps
    send_to_pipeline(:compile, :css)
  end

  desc "Clean javascipt assets"
  task :clean_js do
    load_apps
    send_to_pipeline(:clean, :js)
  end

  desc "Clean CSS assets"
  task :clean_css do
    load_apps
    send_to_pipeline(:clean, :css)
  end

end
