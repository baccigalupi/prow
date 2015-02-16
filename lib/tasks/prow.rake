namespace :prow do
  desc "Copies over all the files needed for a Prow Application"
  task :create do
    Prow::AppBuilder::Create.new.perform
    Prow::PagesCompiler.new.compile
    Prow::AppBuilder::StyleCompiler.perform
  end

  namespace :compile do
    desc "Complile all the mustache to ruby using the pages.json file"
    task :html do
      Prow::PagesCompiler.new.compile
    end

    desc "Uses compass to compile all the styles sheets in the sass directory"
    task :css do
      Prow::AppBuilder::StyleCompiler.perform
    end
  end
end
