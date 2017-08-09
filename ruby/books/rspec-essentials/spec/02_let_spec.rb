=begin
References:
[1] https://relishapp.com/rspec/rspec-core/v/3-6/docs/helper-methods/let-and-let

Use let to define a memoized helper method. The value will be cached across
multiple calls in the same example but not across examples.

Note that let is lazy-evaluated: it is not evaluated until the first time
the method it defines is invoked. You can use let! to force the method's
invocation before each example.

By default, let is threadsafe, but you can configure it not to be
by disabling config.threadsafe, which makes let perform a bit faster.

=end

require 'rspec'

$count = 0
describe "let" do
  # using let or let! produces the same results
  let(:count) { $count += 1 }

  it "memoizes the value" do
    expect(count).to eq(1) #=> true
    expect(count).to eq(1) #=> true
  end

  it "is not cached across examples" do
    expect(count).to eq(2) #=> true
  end
end
