const expect = chai.expect;

describe('global functions', function() {
  let returnsThisAndArgs;
  let bob;


  beforeEach(function(){
     returnsThisAndArgs = function(){ return {thisValue: this, arguments: Array.from(arguments)} }
     bob = {name: 'bob'}
     age = 18
  })

  describe('invokeFunction', function(){
    it('calls and returns the function as a callback, that shows that this is global from the callback', function(){
      expect(justInvoke(returnsThisAndArgs).thisValue).to.equal(window)
    })
  })

  describe('setThisWithCall', function(){
    let age = 18
    it('calls and returns the function as a callback, and assigns this to be bob while passing an argument to the invoked function', function(){
      let result = setThisWithCall(returnsThisAndArgs, bob, 18)
      expect(result.thisValue).to.equal(bob)
      expect(result.arguments[0]).to.equal(18)
    })
  })

  describe('setThisWithApply', function(){
    let age = 20
    let hairColor = 'black'
    it('calls and returns the function as a callback, and assigns this to be bob while passing all arguments to the invoked function', function(){
      let result = setThisWithApply(returnsThisAndArgs, bob, [age, hairColor])
      expect(result.thisValue).to.equal(bob)
      expect(result.arguments[0]).to.equal(20)
      expect(result.arguments[1]).to.equal('black')
    })

    it('calls and returns the function as a callback, assigns this to be bob, and sets the array as arguments', function(){
      let returnsThisWithArgs = function(firstArgument, secondArgument){
        return [this].concat(firstArgument).concat(secondArgument)
      }
      expect(setThisWithApply(returnsThisWithArgs, bob, ['foo', 'bar'])[0]).to.equal(bob)
      expect(setThisWithApply(returnsThisWithArgs, bob, ['foo', 'bar']).length).to.equal(3)
    })
  })

  describe('returnNewFunctionOf', function(){
    let fred;
    let functionToBeCopied;

    beforeEach(function(){
      functionToBeCopied = function (){
        return this
      }
     fred = { name: 'fred'}
    })
    it('returns a new function', function(){
      expect(returnNewFunctionOf(functionToBeCopied)).to.not.equal(functionToBeCopied)
      expect(typeof returnNewFunctionOf(functionToBeCopied)).to.equal("function")
    })
    it('sets the this argument to fred', function(){
      let newFunction = returnNewFunctionOf(functionToBeCopied, fred)
      expect(newFunction()).to.equal(fred)
    })
  })
})
