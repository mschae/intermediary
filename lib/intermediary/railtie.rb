module Intermediary
  class Railtie < Rails::Railtie
    rake_tasks do
      load 'tasks/intermediary.rake'
    end
  end
end
