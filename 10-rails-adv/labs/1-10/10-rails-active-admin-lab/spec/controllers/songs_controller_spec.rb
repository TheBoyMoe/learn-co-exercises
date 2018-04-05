require 'rails_helper'

RSpec.describe SongsController do
  it { should_not respond_to :update }
  it { should_not respond_to :edit }
  it { should_not respond_to :new }
  it { should_not respond_to :create }
  it { should_not respond_to :destroy }
end
