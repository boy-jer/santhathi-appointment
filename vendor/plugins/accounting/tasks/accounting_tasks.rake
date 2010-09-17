namespace :accounting do
  task :sync do
    system "rsync -ruv vendor/plugins/accounting/db/migrate db"
    system "rsync -ruv vendor/plugins/accounting/public ."
  end
end
