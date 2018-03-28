describe("ship with a crew", () => {
  let tristan, jon, katie, aluminumFalcon;

  beforeEach(() => {
    tristan = new CrewMember("Pilot");
    jon = new CrewMember("Defender");
    katie = new CrewMember("Gunner");
    aluminumFalcon = new Spaceship(
      "Millenium Falcon",
      [tristan, jon, katie],
      5,
      4
    );
  });

  describe("spaceship docked", () => {
    it("should return false for a ship with a crew", () => {
      expect(aluminumFalcon.docked).to.eq(false);
    });
  });

  describe("spaceship charge phasers", () => {
    it("a crew member assigned to a ship should be able to charge phasers", () => {
      tristan.chargePhasers();
      expect(aluminumFalcon.phasersCharge).to.match(/uncharged/i);

      katie.chargePhasers();
      expect(aluminumFalcon.phasersCharge).to.match(/charged/i);
    });
  });

  describe("engage warp drive", () => {
    it("should set spaceship warp drive to 'engaged' when pilot uses engageWarpDrive()", () => {
      jon.engageWarpDrive();
      expect(aluminumFalcon.warpDrive).to.match(/disengaged/i);

      tristan.engageWarpDrive();
      expect(aluminumFalcon.warpDrive).to.match(/engaged/i);
    });
  });

  describe("cloak", () => {
    it("should cloak the ship when a defender uses setsInvisibility()", () => {
      katie.setsInvisibility();
      expect(aluminumFalcon.cloaked).to.eq(false);

      jon.setsInvisibility();
      expect(aluminumFalcon.cloaked).to.eq(true);
    });
  });

  describe("crew member with a currentShip", () => {
    it("a newly created spaceship should be an instance of a spaceship", () => {
      expect(tristan.currentShip).to.be.an("object");
      expect(tristan.currentShip).to.be.an.instanceOf(Spaceship);
      expect(tristan.currentShip.constructor).to.be.a("function");
    });

    it("should create the association between a crew member and ship", () => {
      expect(tristan.currentShip.shields).to.eq(4);
      expect(tristan.currentShip).to.have.own.property(
        "name",
        "Millenium Falcon"
      );
      //tristan is an instance of crewMember and is passed in as first arg to spaceship; therefore, tristan should be the first crew member of tristan's spaceship
      expect(tristan.currentShip.crew[0]).to.deep.eq(tristan);
      expect(tristan.currentShip.crew[1]).to.deep.eq(jon);
      expect(tristan.currentShip.crew[2]).to.deep.eq(katie);
    });
  });
});
