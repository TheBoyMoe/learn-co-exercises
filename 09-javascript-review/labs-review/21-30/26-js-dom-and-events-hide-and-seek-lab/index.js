function getFirstSelector(elm){
  return document.querySelector(elm);
}

function nestedTarget(){
  return document.querySelector('#nested .target');
}

function deepestChild(){
	let node = document.getElementById('grand-node')
  let nextNode = node.children[0]

  while (nextNode) {
    node = nextNode
    nextNode = node.children[0]
  }

  return node
}

function increaseRankBy(n){
	const lists = document.querySelectorAll('.ranked-list')

  for (let i = 0; i < lists.length; i++) {
    let nodes = lists[i].children

    for (let j = 0; j < nodes.length; j++) {
      nodes[j].innerHTML = parseInt(nodes[j].innerHTML) + n
    }
  }
}
