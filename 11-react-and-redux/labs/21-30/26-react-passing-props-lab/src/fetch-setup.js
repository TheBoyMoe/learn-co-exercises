import 'isomorphic-fetch';
import fetchMock from 'fetch-mock';
import { getFruitTypes, getFruitBasket } from './fruit';

fetchMock.get('/api/fruit', getFruitBasket());
fetchMock.get('/api/fruit_types', getFruitTypes());

export default fetchMock;
