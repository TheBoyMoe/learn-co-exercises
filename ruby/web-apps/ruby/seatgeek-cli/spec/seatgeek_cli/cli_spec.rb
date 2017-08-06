require "spec_helper"

RSpec.describe SeatgeekCli do
  it "has a version number" do
    expect(SeatgeekCli::VERSION).not_to be nil
  end

  context SeatgeekCli::CLI do
    let(:cli){SeatgeekCli::CLI.new('146.90.135.180')}

    describe '#initialize' do
      it 'accepts an IP address for the user' do
        # gets the ip set above
        expect(cli.external_ip).to eq('146.90.135.180')
      end

      it 'finds the external ip address of the user' do
        # stub out the request to #get_external_ip - you assume that #get_external_ip always works
        expect(SeatgeekCli::CLI).to receive(:get_external_ip).and_return('146.90.135.180')

        cli = SeatgeekCli::CLI.new
        expect(cli.external_ip).to eq('146.90.135.180')
      end
    end

    describe '#call' do
      it 'welcomes the user upon the launch of the app' do
        VCR.use_cassette('get_user_location') do
          expect{cli.call}.to output("Welcome to seatgeek, the fan site where you can select from millions of tickets for purchase\nYour location is: Wimbledon, GB\n").to_stdout
        end
      end
    end

    describe '#user_location' do
      # makes a call to the internet to fetch the users location
      # from seatgeek, you want to avoid making calls to the internet in
      # tests, could be down and takes time, slowing test performance
      # stub out the call by using the VCR gem - makes the call
      # and saves the data for future use
      it 'returns the user location based on their external ip address' do
        VCR.use_cassette('get_user_location') do
          expect{cli.user_location}.to output("Your location is: Wimbledon, GB\n").to_stdout
        end
      end
    end

  end

end
