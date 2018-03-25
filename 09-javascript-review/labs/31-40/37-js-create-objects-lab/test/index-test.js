describe('objects', function() {
  describe('Dog constructor', function(){
    it("should create a new dog with three properties", function(){
      var caldwell = new Dog("caldwell", "toy poodle", "4 months");
      expect(caldwell).toBeA(Dog);
      expect(caldwell.name).toEqual("caldwell");
      expect(caldwell.age).toEqual("4 months");
      expect(caldwell.breed).toEqual("toy poodle");
    });

  });

  describe('Cat constructor', function(){
    it("should create a new cat with three properties", function(){
      var puff = new Cat("Professor Puff", "Maine Coon", "6 years");
      expect(puff).toBeA(Cat);
      expect(puff.name).toEqual("Professor Puff");
      expect(puff.age).toEqual("6 years");
      expect(puff.breed).toEqual("Maine Coon");
    });

  });

  describe('Ferret constructor', function(){
    it("should create a new ferret with three properties", function(){
      var sugarDaddy = new Ferret("Sugar Daddy", "2 years", "raw meat");
      expect(sugarDaddy).toBeA(Ferret);
      expect(sugarDaddy.name).toEqual("Sugar Daddy");
      expect(sugarDaddy.age).toEqual("2 years");
      expect(sugarDaddy.foodRequirements).toEqual("raw meat");
    });

  });

  describe('Bird constructor', function(){
    it("should create a new bird with two properties", function(){
      var darla = new Bird("Darla", "cockatoo");
      expect(darla).toBeA(Bird);
      expect(darla.name).toEqual("Darla");
      expect(darla.breed).toEqual("cockatoo");
    });

  });

  describe('Fish constructor', function(){
    it("should create a new fish with three properties", function(){
      var pinocchio = new Fish("Pinocchio", "parrot fish", "salt water");
      expect(pinocchio).toBeA(Fish);
      expect(pinocchio.name).toEqual("Pinocchio");
      expect(pinocchio.species).toEqual("parrot fish");
      expect(pinocchio.waterConditions).toEqual("salt water");
    });

  });
});
