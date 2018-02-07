require 'rails_helper'

RSpec.describe Contact, type: :model do
  it {is_expected.to validate_presence_of(:name)}
	it {is_expected.to validate_presence_of(:address)}
	it {is_expected.to validate_presence_of(:phone)}
	it {is_expected.to validate_length_of(:phone).is_at_least(10)}
end
