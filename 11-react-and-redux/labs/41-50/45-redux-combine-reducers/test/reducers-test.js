import { books, recommendedBooks } from '../src/reducers'
import { combineReducers } from 'redux'



const addBook = "ADD_BOOK"
const removeBook = "REMOVE_BOOK"

describe('books reducers', function() {

  var projs = { title: "Professional JavaScript for Web Developers", author: "Nicholas C. Zakas" }
  var fakeBook = { title: "None", author: "No One!" }
  var func = { title: "Functional JavaScript", author: "Michael Fogus" }
  var patterns = { title: "JavaScript Patterns", author: "Stoyan Stefanov" }

  it('responds to the "ADD_BOOK" action by adding the book', function() {
    let action = { type: addBook, payload: projs }
    let state = []
    expect(books(state, action)).toInclude(projs)
  })

  it('does not modify previous state object', function(){
    const state = []
    expect(books(state, { type: addBook, payload: fakeBook })).toNotEqual(state)
  })

  it('responds to the "REMOVE_BOOK" action by removing the book', function() {
    const state = [func, patterns]
    let action1 = { type: removeBook, payload: func }
    let newState = books(state, action1)
    expect(newState).toNotInclude(func)
    let action2 = { type: removeBook, payload: patterns }
    newState = books(newState, action2)
    expect(newState).toNotInclude(patterns)
  })
})


describe('combine reducers', function(){
  const rootReducer = combineReducers({recommendedBooks: recommendedBooks, books: books})

  it('returns a function', function(){
    expect(rootReducer).toBeA(Function)
  })

  it('returns a reducer that correctly passes each piece of state to the correct reducer', function() {
    let state = { books: [{ title: "Functional JavaScript", author: "Michael Fogus" },
                          { title: "JavaScript Patterns", author: "Stoyan Stefanov" }],
                  recommendedBooks: []
                }
    let projs = { title: "Professional JavaScript for Web Developers", author: "Nicholas C. Zakas" }
    let action = { type: addBook, payload: projs }
    expect(rootReducer(state, action).recommendedBooks).toBeAn(Array)
    expect(rootReducer(state, action).recommendedBooks.length).toBe(0)
    expect(rootReducer(state, action).books[2]).toBe(projs)
    expect(rootReducer(state, action).books[0]).toBe(state.books[0])
  })
})
