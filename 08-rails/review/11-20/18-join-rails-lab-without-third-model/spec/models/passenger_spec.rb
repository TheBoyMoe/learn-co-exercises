require 'spec_helper'

describe Passenger do
  let(:passenger) { subject }

  it 'has many taxis' do
    taxi = Taxi.create

    passenger.taxis << taxi
    passenger.save

    expect(taxi.passengers).to include(passenger)
  end

end
