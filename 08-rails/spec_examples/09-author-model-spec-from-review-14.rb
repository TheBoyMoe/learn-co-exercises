require 'rails_helper'

RSpec.describe Author, type: :model do
	it "is valid" do
		author = Author.new(name: "Caligula", phone_number: 5553054425)
		expect(author).to be_valid
	end

	it "is invalid with no name" do
		author = Author.new(phone_number: 5553054425)
		expect(author).to be_invalid
	end

	it "is invalid with a short number" do
		author = Author.new(name: "Caligula", phone_number: 555305442)
		expect(author).to be_invalid
	end

	it "is invalid when email is non-unique" do
		Author.create(name: "Caligula", email: 'caligula@example.com', phone_number: 5553054425)
		author = Author.new(name: "John Smith", email: 'caligula@example.com', phone_number: 5557890001)
		expect(author).to be_invalid
	end
end
