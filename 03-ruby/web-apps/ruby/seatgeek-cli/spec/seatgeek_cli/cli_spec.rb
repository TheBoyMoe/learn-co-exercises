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

    describe '#greet_user' do
      it 'welcomes the user upon the launch of the app' do
          expect{cli.greet_user}.to output("Welcome to seatgeek, the fan site where you can select from millions of tickets for purchase\n").to_stdout
      end
    end

    describe '#print_location' do
      it 'print the user\'s location upon the launch of the app' do
          expect{cli.print_location}.to output("Your location is: Wimbledon, GB\n").to_stdout
      end
    end

    describe '#user_location' do
      # makes a call to the internet to fetch the users location
      # from seatgeek, you want to avoid making calls to the internet in
      # tests, could be down and takes time, slowing test performance
      # stub out the call by using the VCR gem - makes the call
      # and saves the data for future use
      it 'returns the user location based on their external ip address' do
          expect(cli.user_location).to eq("Wimbledon, GB")
      end
    end

    describe '#list_events' do
      it "prints out all the event titles" do
        expect{
         cli #=> trigger the events to load
         SeatgeekCli::Event.clear_all

         # Creating some known data.
         event_1 = SeatgeekCli::Event.new
         event_1.title = "Event 1"
         event_1.save

         event_2 = SeatgeekCli::Event.new
         event_2.title = "Event 2"
         event_2.save

         cli.list_events
       }.to output("Events near you:\n1. Event 1\n2. Event 2\n").to_stdout
      end
    end

  end

end
