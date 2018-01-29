require 'spec_helper'

describe Taxi do
  let(:taxi) { subject }

  it 'has many passengers' do
    passenger = Passenger.create
    taxi.passengers << passenger
    taxi.save

    expect(passenger.taxis).to include(taxi)
  end

end
