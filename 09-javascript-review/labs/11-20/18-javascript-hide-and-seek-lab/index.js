// solution

var getFirstSelector = (selector)=>{
  return document.querySelector(selector)
}

var nestedTarget = ()=>{
  return getFirstSelector('#nested').querySelector('.target')
}

var deepestChild = ()=>{
  let node = document.getElementById('grand-node')
  let nextNode = node.children[0]

  while (nextNode) {
    node = nextNode
    nextNode = node.children[0]
  }

  return node
}

var increaseRankBy = (n)=>{
  const Lists = document.querySelectorAll('.ranked-list')

  for (let i = 0; i < Lists.length; i++) {
    let items = Lists[i].children // grab the child elements (li) of each ul in turn

    for (let j = 0; j < items.length; j++) {
      items[j].textContent = parseInt(items[j].textContent) + n
    }
  }
}
