const oldID = Math.floor(Math.random() * 100) + 1;

const ages = [26.4, 21, 49.5, 83, 99, 53.3, 74, 94.9, 40, 56.2];

const currentAge = ages[Math.floor(Math.random() * ages.length)];

const currentAgeIsInteger = Number.isInteger(currentAge);

const spyOnNumberIsInteger = sinon.stub(Number, 'isInteger').returns(currentAgeIsInteger);

const randNum = Math.random();

const spyOnMathRandom = sinon.stub(Math, 'random').returns(randNum);
