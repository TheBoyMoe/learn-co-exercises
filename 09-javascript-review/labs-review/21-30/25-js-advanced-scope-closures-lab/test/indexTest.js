const expect = chai.expect;

describe('closures', function() {
  describe('produceDrivingRange', function(){
    it('returns a function', function(){
      expect(typeof produceDrivingRange()).to.equal('function')
    })

    it('takes an argument of blockRange which is then used to calculate if something is within range', function(){
      let eightBlockRange = produceDrivingRange(8)
      expect(eightBlockRange('10th', '20th')).to.equal('2 blocks out of range')
      expect(eightBlockRange('10th', '14th')).to.equal('within range by 4')
    })

    it('returns when something is out of range', function(){
      let twentyBlockRange = produceDrivingRange(20)
      expect(twentyBlockRange('10th', '20th')).to.equal('within range by 10')
      expect(twentyBlockRange('10th', '40th')).to.equal('10 blocks out of range')
    })
  })

  describe('produceTipCalculator', function(){
    it('returns a function', function(){
      expect(typeof produceTipCalculator()).to.equal('function')
    })

    it('configures the percentage tip returned', function(){
      let tenPercentTip = produceTipCalculator(.10)
      expect(tenPercentTip(50)).to.equal(5)
      expect(tenPercentTip(30)).to.equal(3)
    })
  })

  describe('createDriver', function(){
    const Driver = createDriver()

    it('returns a class that allows us to create a driver with a name attribute', function(){
      expect(new Driver('Sam').name).to.equal('Sam')
    })

    it('increments the driverId each time a driver is created', function(){
      expect(new Driver('Sam').id).to.not.equal(new Driver('Bob').id)
    })
  })
})
