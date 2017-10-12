class StaticController < ApplicationController

  # explicitly set which page rails should render for the about action
  # add 'about.html.erb' file to implicitly render about action
  def about
    # render 'some_page'
  end
end
