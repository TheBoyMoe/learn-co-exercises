require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) { @user = User.new(email: 'user@example.com') }

  subject { @user }

  it { should respond_to(:email) }

  it "#email returns a string" do
    expect(@user.email).to match 'user@example.com'
  end

  it "#role is 'user' by default" do
    expect(@user.role).to eq "user"
  end

  it "#role can be set to :vip" do
    @user.role = :vip
    expect(@user.role).to eq "vip"
  end

  it "#role can be set to :admin" do
    @user.role = :admin
    expect(@user.role).to eq "admin"
  end
end
