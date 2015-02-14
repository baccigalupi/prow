namespace :prow do
  desc "Copies over all the files needed for a Prow Application"
  task :create do
    Prow::AppBuilder::Create.new.perform
    Prow::PagesCompiler.new.compile
  end
end
