describe('President', function() {
  let lyndonJohnson
  before(() => {
    lyndonJohnson = new President("Lyndon B Johnson", "Democrat", "1963-1969", "Texas")
  })

  describe('Presidents Constructor Function', function() {
    it('can create a president with a name, home state, political party, and years in office', function() {
      expect(lyndonJohnson).toBeA(President)
      expect(lyndonJohnson.name).toEqual("Lyndon B Johnson")
      expect(lyndonJohnson.politicalParty).toEqual("Democrat")
      expect(lyndonJohnson.yearsInOffice).toEqual("1963-1969")
      expect(lyndonJohnson.homeState).toEqual("Texas")
    })
  })

  describe('veto()', function() {
    it('returns "NO!"', function() {
      expect(lyndonJohnson.veto()).toEqual("NO!")
    })
  })

  describe('passBill()', function() {
    it('returns "You can do that!"', function() {
      expect(lyndonJohnson.passBill()).toEqual("You can do that!")
    })
  })

  describe('doCharity()', function() {
    it('returns "I like to help people."', function() {
      expect(lyndonJohnson.doCharity()).toEqual("I like to help people.")
    })
  })

  describe('conductPressInterview()', function() {
    it('returns "I am proud to be an American."', function() {
      expect(lyndonJohnson.conductPressInterview()).toEqual("I am proud to be an American.")
    })
  })

  describe('sayHi()', function() {
    it('returns "Hi, my name is <name>, I am from <homestate>. I represent the <politcalParty>s and was in office <yearsInOffice>."', function() {
      expect(lyndonJohnson.sayHi()).toEqual("Hi, my name is Lyndon B Johnson. I am from Texas. I represent the Democrats, and was in office 1963-1969.")
    })
  })
})
