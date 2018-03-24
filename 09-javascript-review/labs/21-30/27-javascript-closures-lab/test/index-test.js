describe('closures', function() {
  describe('Three point turn', function () {
    it('should have a `bumpCounter()` function', () => {
      expect(bumpCounter).toBeA('function');
    });

    it('should contain the other variables inside the closure', () => {
      expect(window.addBump).toNotExist();
      expect(window.getBumps).toNotExist();
      expect(window.counter).toNotExist();
    });

    it('should return the `addBump()` and `getBumps()` function', () => {
      const { addBump, getBumps } = bumpCounter();
      expect(addBump).toBeA('function');
      expect(getBumps).toBeA('function');
    });

    it('should return the counter when `getBumps()` is called', () => {
      const { getBumps } = bumpCounter();
      expect(getBumps()).toBeA('number');
    });

    it('should increase the counter when `addBump()` is called', () => {
      const { addBump, getBumps } = bumpCounter();
      expect(getBumps()).toEqual(0);
      addBump();
      expect(getBumps()).toEqual(1);
    });
  });

  describe('Dangerous animals', function () {
    it('should have a `createAnimal()` function', () => {
      expect(createAnimal).toBeA('function');
    });

    it('should return a function when calling the `createAnimal()` closure', () => {
      expect(createAnimal()).toBeA('function');
    });

    it('should have a `sharkCreator` variable', () => {
      expect(sharkCreator).toBeA('function');
    });

    it('should have a `sharkWithFrickinLaserbeam` variable', () => {
      expect(sharkWithFrickinLaserbeam).toBeA('object');
      expect(sharkWithFrickinLaserbeam.animalType).toEqual('Shark');
      expect(sharkWithFrickinLaserbeam.deadlyDevice).toEqual('Laserbeam');
    });

    it('should have a `sharkWithFrickinCannon` variable', () => {
      expect(sharkWithFrickinCannon).toBeA('object');
      expect(sharkWithFrickinCannon.animalType).toEqual('Shark');
      expect(sharkWithFrickinCannon.deadlyDevice).toEqual('Cannon');
    });
  });
})
