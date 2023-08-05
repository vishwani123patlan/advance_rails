require 'csv'
class User < ApplicationRecord
	has_one :address
	after_create do 
		UserWorker.perform_async(self.id)
		UserLogWorker.perform_async(self.id)
	end

	# cahed user

	def self.cached_user(user_id)
		cached_user = $redis.get("user_#{user_id}")

		if cached_user.nil?
			user = find_by_id(user_id)
			if user
				debugger
				data = {user: user, address: user.address}
				$redis.setex("user_#{user_id}", 1.hour, data.to_json)
			end
			user
		else
			User.new(JSON.parse(cached_user))
		end
	end

  # Add a method to handle importing users from CSV
  def self.import_users_from_csv(file)
    users = []
    CSV.foreach(file.path, headers: true) do |row|
      user_params = row.to_hash.slice('name', 'email')
      address_params = row.to_hash.slice('street', 'city')

      # Build the user and associated address records
      user = new(user_params)
      user.build_address(address_params)

      users << user
    end

    # Import users and addresses in a transaction
    User.transaction do
      User.import(users, recursive: true, validate: true)
    end
  end
end
