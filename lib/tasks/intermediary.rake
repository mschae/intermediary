namespace :intermediary do
  task :listen => :environment do
    Intermediary::Listeners.activate_all

    (Thread.list - [Thread.current]).each(&:join)
  end
end
