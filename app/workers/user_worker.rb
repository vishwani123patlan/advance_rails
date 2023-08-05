class UserWorker
	include Sidekiq::Worker 
	queue_as :default

	sidekiq_options priority: 5, retry: 3

	ADJECTIVES = ['Happy', 'Sunny', 'Clever', 'Brave', 'Gentle', 'Sweet']
	NOUNS = ['Cat', 'Dog', 'Bird', 'Tree', 'River', 'Star']

	def random_name
	  "#{ADJECTIVES.sample}-#{NOUNS.sample}"
	end

	def perform(user_id)
		User.find(user_id).update(name: random_name)
	end
end