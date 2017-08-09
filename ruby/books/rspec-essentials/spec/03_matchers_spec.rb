=begin
  Reference:
  [1] https://relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
  [2] https://www.safaribooksonline.com/library/view/rspec-essentials/9781784395902/ch02s03.html (custom matchers and errors)
  Rspec comes with many built in matchers, but allows you to create your own

=end

expect([]).to respond_to(:size)
expect([]).to be_empty
expect([].first).to be_nil

expect("foo bar").to match(/^f.+r$/)
expect([1,2]).to include(2)
expect([1,2,3]).to match_array([3,2,1])

# We don't absolutely need any matchers except for 'eq'. Any of the preceding examples could be rewritten to use that instead, e.g.
expect([1,2].include?(2)).to eq(true)

# benefit of using built-in matchers - tailored error messages & the tests are easier to read
# message has no context
expect([1,2,3].include?(4)).to eq(true)
# => expected: true
#         got: false

expect([1,2,3]).to include(4)
# => expected [1, 2, 3] to include 4

# equivalence
expect(actual).to eq(expected) # passes if actual == expected
expect(actual).to eql(expected)   # passes if actual.eql?(expected)
expect(actual).to equal(expected) # passes if actual.equal?(expected)

# comparisons
# NOTE: `expect` does not support `=~` matcher.
expect(actual).to be >  expected
expect(actual).to be >= expected
expect(actual).to be <= expected
expect(actual).to be <  expected
expect(actual).to be_between(minimum, maximum).inclusive
expect(actual).to be_between(minimum, maximum).exclusive
expect(actual).to match(/expression/)
expect(actual).to be_within(delta).of(expected)
expect(actual).to start_with expected
expect(actual).to end_with expected

# types/classes
expect(actual).to be_instance_of(expected)
expect(actual).to be_kind_of(expected)
expect(actual).to respond_to(expected)


# truthiness
expect(actual).to be_truthy    # passes if actual is truthy (not nil or false)
expect(actual).to be true      # passes if actual == true
expect(actual).to be_falsey    # passes if actual is falsy (nil or false)
expect(actual).to be false     # passes if actual == false
expect(actual).to be_nil       # passes if actual is nil
expect(actual).to exist        # passes if actual.exist? and/or actual.exists? are truthy
expect(actual).to exist(*args) # passes if actual.exist?(*args) and/or actual.exists?(*args) are truthy

# errors and throws
expect { ... }.to raise_error
expect { ... }.to raise_error(ErrorClass)
expect { ... }.to raise_error("message")
expect { ... }.to raise_error(ErrorClass, "message")

expect { ... }.to throw_symbol
expect { ... }.to throw_symbol(:symbol)
expect { ... }.to throw_symbol(:symbol, 'value')


# predicate matchers
expect(actual).to be_xxx         # passes if actual.xxx?
expect(actual).to have_xxx(:arg) # passes if actual.has_xxx?(:arg)

expect([]).to      be_empty
expect(:a => 1).to have_key(:a)


# collections
expect(actual).to include(expected)
expect(array).to match_array(expected_array)
# ...which is the same as:
expect(array).to contain_exactly(individual, elements)

expect([1, 2, 3]).to     include(1)
expect([1, 2, 3]).to     include(1, 2)
expect(:a => 'b').to     include(:a => 'b')
expect("this string").to include("is str")
expect([1, 2, 3]).to     contain_exactly(2, 1, 3)
expect([1, 2, 3]).to     match_array([3, 2, 1])
