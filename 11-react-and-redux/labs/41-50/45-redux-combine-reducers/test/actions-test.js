import { addBook, addRecommendedBook, removeBook, removeRecommendedBook } from '../src/actions';

describe('addBook action creator', function() {
  it('returns an object with type "ADD_BOOK"', function() {
    let eloquentjs = {title: "Eloquent JavaScript", author: "Marijn Haverbeke"}
    expect(addBook(eloquentjs).type).toEqual("ADD_BOOK")
  })
  it('returns an object with payload of the book to be added', function() {
    let jsguide = {title: "JavaScript: The Definitive Guide", author: "David Flanagan"}
    expect(addBook(jsguide).payload.title).toEqual(jsguide.title)
    expect(addBook(jsguide).payload.author).toEqual(jsguide.author)
  })
})

describe('addRecommendedBook action creator', function() {
  it('returns an object with type "ADD_RECOMMENDED_BOOK"', function() {
    let jsninja = {title: "Secrets of the JavaScript Ninja", author: "John Resig"}
    expect(addRecommendedBook(jsninja).type).toEqual("ADD_RECOMMENDED_BOOK")
  })
  it('returns an object with payload of the book to be recommended', function(){
    let jsthegoodparts = {title: "JavaScript, the Good Parts", author: "Douglas Crockford"}
    expect(addRecommendedBook(jsthegoodparts).payload.title).toEqual(jsthegoodparts.title)
    expect(addRecommendedBook(jsthegoodparts).payload.author).toEqual(jsthegoodparts.author)
  })
})

describe('remove book action creator', function(){
  it('returns an object with type "REMOVE_BOOK"', function () {
    let youdontknowjs = {title: "You Don't Know JS", author: "Kyle Simpson"}
    expect(removeBook(youdontknowjs).type).toEqual('REMOVE_BOOK')
  })
  it('returns an object with payload of the book to be removed', function (){
    let jsallonge = {title: "Javascript Allonge", author: "Reginald Braithwaite"}
    expect(removeBook(jsallonge).payload.title).toEqual(jsallonge.title)
    expect(removeBook(jsallonge).payload.author).toEqual(jsallonge.author)
  })
})

describe('remove recommended book action creator', function(){
  it('returns an object with type "REMOVE_RECOMMENDED_BOOK"', function () {
    let youdontknowjs = {title: "You Don't Know JS", author: "Kyle Simpson"}
    expect(removeRecommendedBook(youdontknowjs).type).toEqual('REMOVE_RECOMMENDED_BOOK')
  })
  it('returns an object with payload of the book to be removed', function (){
    let oojs = {title: "The Principles of Object Oriented JavaScript", author: "Nicholas C. Zakas"}
    expect(removeRecommendedBook(oojs).payload.title).toEqual(oojs.title)
    expect(removeRecommendedBook(oojs).payload.author).toEqual(oojs.author)
  })
})
