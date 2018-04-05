class LeadsWorker
  require 'csv'
  include Sidekiq::Worker

  # takes in the data for processing
  def perform(leads_file)
    CSV.foreach(leads_file, headers: true) do |lead|
      Customer.create(email: lead[0], first_name: lead[1], last_name: lead[2])
    end
  end

end
