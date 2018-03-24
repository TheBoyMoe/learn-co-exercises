describe('Uncovering alliances', function() {
  it('should have a `sortedRobots` array', function() {
    expect(sortedRobots).toBeAn('array');
  });

  it('should have the same length as the original `robots` array', function() {
    expect(sortedRobots.length).toEqual(robots.length);
  });

  it('should have 4 decepticons in the `sortedRobots` array', function() {
    expect(sortedRobots.filter(r => r.alliance === 'decepticon').length).toEqual(4);
  });

  it('should have 4 autobots in the `sortedRobots` array', function() {
    expect(sortedRobots.filter(r => r.alliance === 'autobot').length).toEqual(4);
  });

  it('should not have modified the objects in the original `robots` array', function() {
    expect(robots.every(r => r.alliance === null)).toBeTruthy('The original objects in the `robots` array have been modified.');
  });
});

describe('Zebra stripes', function() {
  it('should have a `coloredZebraStripes` array', function() {
    expect(coloredZebraStripes).toBeAn('array');
  });

  it('should have the same length as the original `zebraStripes` array', function() {
    expect(coloredZebraStripes.length).toEqual(zebraStripes.length);
  });

  it('should have 4 `black` stripes', function() {
    expect(coloredZebraStripes.filter(stripe => stripe.color === 'black').length).toEqual(4);
  });

  it('should have 4 `white` stripes', function() {
    expect(coloredZebraStripes.filter(stripe => stripe.color === 'white').length).toEqual(4);
  });

  it('should not have modified the objects in the original `robots` array', function() {
    expect(zebraStripes.every(stripe => stripe.color === null)).toBeTruthy('The original objects in the `zebraStripes` array have been modified.');
  });
});
