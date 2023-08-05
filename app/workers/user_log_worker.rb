class UserLogWorker
	include Sidekiq::Worker
	queue_as :default
	sidekiq_options priority: 10, retry: 5

	def perform(user_id)
		UserLog.create(user_id: user_id)
	end
end
