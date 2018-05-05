const expect = chai.expect;

describe('index.js', function () {
  const drivers = [];
  const extendedDrivers = [];

  beforeEach(function () {
    drivers.length = 0;

    drivers.push(
      { name: 'Sally',   revenue: 400 },
      { name: 'Annette', revenue: 200 },
      { name: 'Jim',     revenue: 150 }
    );

    extendedDrivers.length = 0;

    extendedDrivers.push(
      { name: 'Sally',   revenue: 400 },
      { name: 'Annette', revenue: 200 },
      { name: 'Jim',     revenue: 150 },
      { name: 'Sally',   revenue: 200 }
    );
  });

  describe('driversWithRevenueOver()', function () {
    it('returns an array of all matching drivers', function () {
      expect(driversWithRevenueOver(drivers, 250)).to.eql([
        { name: 'Sally', revenue: 400 }
      ]);

      expect(driversWithRevenueOver(drivers, 199)).to.eql([
        { name: 'Sally',   revenue: 400 },
        { name: 'Annette', revenue: 200 }
      ]);
    });

    it('returns an empty array if there is no match', function () {
      expect(driversWithRevenueOver(drivers, 500)).to.eql([]);
    });
  });

  describe('driverNamesWithRevenueOver()', function () {
   it('returns an array of all matching drivers names as string', function () {
      expect(driverNamesWithRevenueOver(drivers, 199)).to.eql([ 'Sally', 'Annette' ]);
    });

    it('returns an empty array if there is no match', function () {
      expect(driverNamesWithRevenueOver(drivers, 500)).to.eql([]);
    });
  });

  describe('exactMatch()', function () {
    it('returns an array of all matching drivers', function () {
      expect(exactMatch(extendedDrivers, { name: 'Sally' })).to.eql([
        { name: 'Sally', revenue: 400 },
        { name: 'Sally', revenue: 200 }
      ]);

      expect(exactMatch(extendedDrivers, { revenue: 200 })).to.eql([
        { name: 'Annette', revenue: 200 },
        { name: 'Sally',   revenue: 200 }
      ]);
    });

    it('returns an empty array if there is no match', function () {
      expect(exactMatch(extendedDrivers, { revenue: 500 })).to.eql([]);

      expect(exactMatch(extendedDrivers, { name: 'Alex' })).to.eql([]);
    });
  });

  describe('exactMatchToList()', function () {
    it('returns an array of names for all matching drivers', function () {
      expect(exactMatchToList(extendedDrivers, { name: 'Sally' })).to.eql([ 'Sally', 'Sally' ]);

      expect(exactMatchToList(extendedDrivers, { revenue: 200 })).to.eql([ 'Annette', 'Sally' ]);
    });

    it('returns an empty array if there is no match', function () {
      expect(exactMatchToList(extendedDrivers, { revenue: 500 })).to.eql([]);

      expect(exactMatchToList(extendedDrivers, { name: 'Alex' })).to.eql([]);
    });
  });
});
