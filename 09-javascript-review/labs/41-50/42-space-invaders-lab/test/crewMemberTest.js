const expect = chai.expect;

describe("crewMember.js", () => {
  let tristan, jon, katie;
  beforeEach(() => {
    tristan = new CrewMember("Pilot");
    jon = new CrewMember("Defender");
    katie = new CrewMember("Gunner");
  });

  it("should know their position", () => {
    expect(tristan.position).to.eq("Pilot");
    expect(jon.position).to.eq("Defender");
    expect(katie.position).to.eq("Gunner");
  });

  it("should should return 'Looking for a Rig' if they aren't assigned to a ship", () => {
    expect(tristan.currentShip).to.match(/Looking for a Rig/i);
  });

  it("should return 'had no effect' when the crew member tries to use their special ability when not assigned to a ship", () => {
    expect(tristan.engageWarpDrive()).to.match(/had no effect/i);
    expect(jon.setsInvisibility()).to.match(/had no effect/i);
    expect(katie.chargePhasers()).to.match(/had no effect/i);
  });
});

