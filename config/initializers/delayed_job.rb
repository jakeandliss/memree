Delayed::Worker.logger = Logger.new(File.join(Rails.root, 'log', 'delayed_job.log'))

if(!File.exists?(Rails.root.join('tmp','pids', 'delayed_job.pid')))
    system "echo \"Starting delayed_jobs...\""
    system "./bin/delayed_job start &"
else
	system "echo \"delayed_jobs is running\""
end
