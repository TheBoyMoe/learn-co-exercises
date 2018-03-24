describe('reducers', function() {
  describe('Technologic', function() {
    it('should have a `totalBatteries` variable', function() {
      expect(totalBatteries).toExist();
    });

    it('should have a number as a result', function() {
      expect(totalBatteries).toBeA('number');
    });

    it('should have made the sum of all the assembled batteries', function() {
      expect(totalBatteries).toEqual(31);
    });
  });

  describe('The perfect monologue', function() {
    it('should have a `wordCountMap` variable', function() {
      expect(wordCountMap).toExist();
    });

    it('should have an object as a result', function() {
      expect(wordCountMap).toBeAn('object');
    });

    it('should have made the correct word count for all sentences', function() {
      const expectedOutput = { '1': 2, '4': 1, '6': 3, '7': 2, '9': 1, '11': 1, '14': 1, '15': 3 };
      expect(JSON.stringify(wordCountMap)).toEqual(JSON.stringify(expectedOutput));
    });
  });
});
