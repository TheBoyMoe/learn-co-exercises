=begin

params hash

{
  :person => {
    :name => "Avi",
    :addresses_attributes => {
      "0" => {
        :street_address_1 => "33 West 26th St",
        :street_address_2 => "Apt 2B",
        :city => "New York",
        :state => "NY",
        :zipcode => "10010",
        :address_type => "Work"
      },
      "1" => {
        :street_address_1 => "11 Broadway",
        :street_address_2 => "2nd Floor",
        :city => "New York",
        :state => "NY",
        :zipcode => "10004",
        :address_type => "Home"
      },
      ...
    }
  }
}

=end

class PeopleController < ApplicationController

  def index
    @people = Person.all
  end

  def show
    @person = Person.find(params[:id])
  end

  def new
    @person = Person.new
    # we need to add some fields for the `fields_for` helper to generate
    # the text_fields in the new.html.erb view
    # this will add two address blocks, one for each of 'home' and 'work'
    @person.addresses.build(address_type: 'work')
    @person.addresses.build(address_type: 'home')
  end

  def create
    # this particular technique does not stop duplicate addresses being created
    person = Person.new(person_params)
    if person.save
      redirect_to people_path
    else
      render :new
    end
  end

  private
    def person_params
      params.require(:person).permit(
          :name,
          addresses_attributes: [
              :street_address_1,
              :street_address_2,
              :city,
              :state,
              :zipcode,
              :address_type
          ]
      )
    end

end
