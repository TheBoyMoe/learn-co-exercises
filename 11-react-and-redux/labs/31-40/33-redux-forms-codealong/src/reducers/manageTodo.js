// implement reducer
const manageTodo = (state = { todos: [] }, action) => {
  switch(action.type){
    case 'ADD_TODO':
      return { todos: state.todos.concat(action.todo)};
    default:
      return state;
  }
};
export default manageTodo;
