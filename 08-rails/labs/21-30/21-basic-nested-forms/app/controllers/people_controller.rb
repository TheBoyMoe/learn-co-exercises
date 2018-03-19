class PeopleController < ApplicationController
  def new
    @person = Person.new
    # address fields will not be displayed without some content
    @person.addresses.build(address_type: 'work address')
    @person.addresses.build(address_type: 'home address')
  end

  def create
    Person.create(person_params)
    redirect_to people_path
  end

  def index
    @people = Person.all
  end

  private

  def person_params
    params.require(:person).permit(:name, addresses_attributes: [
        :street_address_1,
        :street_address_2,
        :city,
        :state,
        :zipcode,
        :address_type
    ])
  end
end
