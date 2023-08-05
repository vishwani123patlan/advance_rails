class UserLogCreateJob < ApplicationJob
  queue_as :default
  
  after_perform do |job|
    Rails.logger.info("#{Time.now}: Job completed. #{job.inspect}")
  end

  def perform(user_id)
    # Do something later
    UserLog.create(user_id: user_id)
  end
end
