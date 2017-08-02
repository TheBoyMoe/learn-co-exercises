require 'rspec'
require_relative './../lib/address_validator'

# defining a local variable, address, in each example/it block
describe AddressValidator do
  it "returns false for incomplete address" do
    address = { street: "123 Any Street", city: "Anytown" }
    expect(AddressValidator.valid?(address)).to eq(false)
  end

  it "missing_parts returns an array of missing required parts" do
    address = { street: "123 Any Street", city: "Anytown" }
    expect(AddressValidator.missing_parts(address)).to eq([:region, :postal_code, :country])
  end
end

# instead, you could define one-off values that are shared across examples within the scope of the describe block using a local function, e.g.
describe AddressValidator do
  def address
    { street: "123 Any Street", city: "Anytown" }
  end

  it "returns false for incomplete address" do
    expect(AddressValidator.valid?(address)).to eq(false)
  end

  it "missing_parts returns an array of missing required parts" do
    expect(
      AddressValidator.missing_parts(address)
    ).to eq([:region, :postal_code, :country])
  end
end

# Or you can use a before block, e.g
describe AddressValidator do

  # this block replaces the 'address' method
  before do
    @address = { street: "123 Any Street", city: "Anytown" }
  end

  it "valid? returns false for incomplete address" do
    expect(
      AddressValidator.valid?(@address)
    ).to eq(false)
  end

  it "missing_parts returns an array of missing required parts" do
    expect(
      AddressValidator.missing_parts(@address)
    ).to eq([:region, :postal_code, :country])
  end
end

# if the local variable needed to change, we could do the following
describe AddressValidator do
  before do
    @address = { street: "123 Any Street", city: "Anytown" }
  end

  it "valid? returns false for incomplete address" do
    expect(AddressValidator.valid?(@address)).to eq(false)
  end

  it "missing_parts returns an array of missing required parts" do
    expect(
      AddressValidator.missing_parts(@address)
    ).to eq([:region, :postal_code, :country])
  end

  context "invalid characters in value" do
    before do
      # notice the value for :city includes special characters
      @address = { street: "123 Any Street", city: "Any$town%" }
    end

    it "invalid_parts returns keys with invalid values" do
      expect(
        AddressValidator.invalid_parts(@address)
      ).to eq([:city])
    end
  end
end

=begin
  we can also use a let helper
    - the argument is the name of the variable to be created, in this case 'address'
    - requires a block, which is evaluated at runtime to provide the value for the object
    - reference let in the same context as you would the loacl variable or function
=end
describe AddressValidator do
  let(:address) { {street: "123 Any Street", city: "Anytown"} }

  it "valid? returns false for incomplete address" do
    expect(AddressValidator.valid?(address)).to eq(false)
  end

  it "missing_parts returns an array of missing required parts" do
    expect(AddressValidator.missing_parts(address)).to eq([:region, :postal_code, :country])
  end

  context "invalid characters in value" do
    let(:address){ {street: "123 Any Street", city: "Any$town%"} }
    it "invalid_parts returns keys with invalid values" do
      expect(AddressValidator.invalid_parts(address)).to eq([:city])
      end
  end

end

=begin
  Instead of a single 'let', we can create separate definitions, and reference them in 'address',  and change one or more of the nested values.

  We can also use 'context' to organise our tests, which is an alias for 'describe'.
   - often the outermost grouping of Rspec examples uses 'describe', and innre groupings use 'context'. Using an inner 'context' block gives us a local scope we we can define our tests with different inputs
=end
describe AddressValidator do
  let(:address) { { street: street, city: city } }
  let(:street)  { "123 Any Street"               }
  let(:city)    { "Anytown"                      }

  it "valid? returns false for incomplete address" do
    expect(AddressValidator.valid?(address)).to eq(false)
  end

  it "missing_parts returns an array of missing required parts" do
    expect(AddressValidator.missing_parts(address)).to eq([:region, :postal_code, :country])
  end

  context "invalid characters in value" do
    let(:city) { "Any$town%" }

    it "invalid_parts returns keys with invalid values" do
      expect(AddressValidator.invalid_parts(address)).to eq([:city])
    end
  end

  context "address is a String" do
    let(:address) { "123 Any St., Anytown" }

    it "valid? returns false for incomplete address" do
      expect(AddressValidator.valid?(address)).to eq(false)
    end
  end

  context "complete address" do
     # we define 'address' as a Hash, but with all values
    let(:address) do
      {
        street:       "123 Any Street",
        city:         "Anytown",
        region:       "Anyplace",
        country:      "Anyland",
        postal_code:  "123456"
      }
    end

    it "valid? returns true" do
      expect(AddressValidator.valid?(address)).to eq(true)
    end

    context "address is a String" do
      let(:address) { "123 Any St., Anytown, CA, USA, 12345" }

      it "valid? returns true" do
        expect(AddressValidator.valid?(address)).to eq(true)
      end
    end
  end
end
