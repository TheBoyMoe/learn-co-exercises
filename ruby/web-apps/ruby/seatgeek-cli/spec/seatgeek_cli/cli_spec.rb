require "spec_helper"

RSpec.describe SeatgeekCli do
  it "has a version number" do
    expect(SeatgeekCli::VERSION).not_to be nil
  end

  context SeatgeekCli::CLI do

    describe '#initialize' do
      it 'accepts an IP address for the user' do
        cli = SeatgeekCli::CLI.new('146.90.135.180')
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
      let(:cli){SeatgeekCli::CLI.new('146.90.135.180')}
      it 'welcomes the user upon the launch of the app' do
        expect{cli.call}.to output("Welcome to seatgeek, the fan site where you can select from millions of tickets for purchase\n").to_stdout
      end
    end

  end

end
