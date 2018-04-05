require 'rails_helper'

RSpec.describe "routing" do
  it "doesn't route artist create and edit routes" do
    expect(get: '/artists/new').to route_to('artists#show', id: "new")
    expect(get: '/artists/edit').to route_to('artists#show', id: "edit")
    expect(post: '/artists').to_not be_routable
    expect(patch: '/artists/update').to_not be_routable
  end

  it "doesn't route song create and edit routes" do
    expect(get: '/songs/new').to route_to('songs#show', id: "new")
    expect(get: '/songs/edit').to route_to('songs#show', id: "edit")
    expect(post: '/artists').to_not be_routable
    expect(patch: '/artists/update').to_not be_routable
  end

end
