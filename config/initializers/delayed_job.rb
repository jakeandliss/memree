Delayed::Worker.logger = Logger.new(File.join(Rails.root, 'log', 'delayed_job.log'))

if(!File.exists?(Rails.root.join('tmp','pids', 'delayed_job.pid')))
    system "RAILS_ENV=production ./bin/delayed_job start -n 5 &"
    system "./bin/delayed_job start &"
else
	system "echo \"delayed_jobs is running\""
end
