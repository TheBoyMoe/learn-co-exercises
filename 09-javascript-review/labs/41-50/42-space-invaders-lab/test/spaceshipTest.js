describe("spaceShip.js", () => {
  describe("Spaceship", () => {
    let spaceship;
    beforeEach(() => {
      spaceship = new Spaceship("The Krestel", [], 5, 4);
    });

    it("should know its own name", () => {
      expect(spaceship.name).to.eq("The Krestel");
    });

    it("should have the correct number of phasers (5)", () => {
      expect(spaceship.phasers).to.eq(5);
    });

    it("should have the correct layer of shields (4)", () => {
      expect(spaceship.shields).to.eq(4);
    });

    it("should have its cloaking set to false by default", () => {
      expect(spaceship.cloaked).to.eq(false);
    });

    it("should have its warp drive set to 'disengaged' by default", () => {
      expect(spaceship.warpDrive).to.match(/disengaged/i);
    });

    it("should be docked if it has no crew", () => {
      expect(spaceship.docked).to.eq(true);
    });

    it("should have its 'phasers' charge set to 'uncharged' by default", () => {
      expect(spaceship.phasersCharge).to.match(/uncharged/i);
    });
  });
});
