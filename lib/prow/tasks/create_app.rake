namespace :prow do
  desc "Copies over all the files needed for a Prow Application"
  task :create_app do
    Prow::CreateApp.new.run
  end
end
