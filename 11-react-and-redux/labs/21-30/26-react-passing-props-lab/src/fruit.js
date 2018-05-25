import _ from 'lodash';
import emoji from 'emojilib';

const fruitTypes = ['berry', 'pepo', 'pome', 'citrus', 'drupe', 'other'];

const fruitTypesMap = {
  grapes: 'berry',
  banana: 'berry',
  strawberry: 'berry',
  melon: 'berry',
  watermelon: 'pepo',
  apple: 'pome',
  green_apple: 'pome',
  pear: 'pome',
  lemon: 'citrus',
  orange: 'citrus',
  tangerine: 'citrus',
  cherries: 'drupe',
  peach: 'drupe',
  pineapple: 'other'
};

let frujis = _.pickBy(emoji.lib, x => {
  return x.keywords.includes('fruit') &&
         !x.keywords.includes('vegetable');
});

frujis = _.mapValues(frujis, (fruji, name) => {
  delete fruji.category;
  return Object.assign({}, fruji, { fruit_type: fruitTypesMap[name] });
});

const getRandomInt = (min, max) => {
  min = Math.ceil(min);
  max = Math.floor(max);
  return Math.floor(Math.random() * (max - min)) + min;
}

const getRandomFruit = () => {
  const fruitNames = Object.keys(frujis);
  const randomFruit = fruitNames[getRandomInt(0, fruitNames.length)];
  return Object.assign({}, { name: randomFruit }, frujis[randomFruit]);
}

const getFruitTypes = () => {
  return fruitTypes;
};

const getFruitBasket = () => {
  const size = getRandomInt(700, 1000);
  let basket = [];
  for (let i=0; i<=size; i++) {
    basket.push(Object.assign({}, getRandomFruit()))
  }
  return basket;
}

export { getFruitBasket, getFruitTypes };
