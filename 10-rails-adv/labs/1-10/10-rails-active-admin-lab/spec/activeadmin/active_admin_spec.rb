require 'rails_helper'

RSpec.describe "ActiveAdmin" do

  it "has the right resources" do
    expect(ActiveAdmin.application.namespaces[:admin].resources[Artist]).to_not eq nil
    expect(ActiveAdmin.application.namespaces[:admin].resources[Song]).to_not eq nil
  end

  let(:resource_class) { Artist }
  let(:all_resources)  { ActiveAdmin.application.namespaces[:admin].resources }
  let(:resource)       { all_resources[resource_class] } 

  it "Artists should not be deletable" do
    expect(resource.defined_actions).not_to include :destroy
  end
end
