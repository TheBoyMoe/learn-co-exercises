describe('Map/reduce lab', () => {
  describe('Updating the API', function () {
    it('should have an `issuesWithUpdatedApiUrl` array', function () {
      expect(issuesWithUpdatedApiUrl).toBeAn('array');
    });

    it('should have the same length as the original `issues` array', function () {
      expect(issuesWithUpdatedApiUrl.length).toEqual(issues.length);
    });

    it('should have replaced the API URL in all issues', function () {
      const hasPassed = issuesWithUpdatedApiUrl.every(issue => {
        const hasOldUrl = issue.url.includes('api.github.com');
        const hasNewUrl = issue.url.includes('api-v2.github.com');
        return !hasOldUrl && hasNewUrl;
      });
      expect(hasPassed).toBeTruthy('The API URL has not been replaced properly in every issue.');
    });

    it('should not have modified the original objects in the `issues` array', function () {
      const hasPassed = issues.every(issue => {
        const hasOldUrl = issue.url.includes('api.github.com');
        return hasOldUrl;
      });
      expect(hasPassed).toBeTruthy('The original objects in the `issues` array have been modified.');
    });
  });

  describe('Counting the comments', function () {
    it('should have a `commentCountAcrossIssues` variable', function () {
      expect(commentCountAcrossIssues).toBeA('number');
    });

    it('should have the right amount of comments', function () {
      expect(commentCountAcrossIssues).toEqual(703);
    });
  });

  describe('Filtering for open arrays', function () {
    it('should have an `openIssues` array', function () {
      expect(openIssues).toBeAn('array');
    });

    it('should only contain open issues', function () {
      const hasPassed = openIssues.every(issue => issue.state === 'open');
      expect(hasPassed).toBeTruthy('The `openIssues` array contains issues that are not open.');
    });
  });

  describe("I'm not a robot", function () {
    it('should have a `nonAutomaticIssues` array', function () {
      expect(nonAutomaticIssues).toBeAn('array');
      expect(nonAutomaticIssues.length).toBeGreaterThan(0);
    });

    it('should only contain issues that are not created automatically', function () {
      const hasPassed = nonAutomaticIssues.every(issue => !issue.body.includes('automatically created by learn.co'));
      expect(hasPassed).toBeTruthy('The `nonAutomaticIssues` array contains issues that were automatically created.');
    });
  });

  describe("Showing off", function () {
    it('should add the appropriate amount of table rows to the HTML', function () {
      const $ = typeof cheerio !== 'undefined' ? cheerio.load(document.body.innerHTML) : jQuery;
      const $rows = $('#results > tr');
      expect($rows.length).toBeGreaterThan(0);
      expect($rows.length).toEqual(nonAutomaticIssues.length);
    });
  });
});
