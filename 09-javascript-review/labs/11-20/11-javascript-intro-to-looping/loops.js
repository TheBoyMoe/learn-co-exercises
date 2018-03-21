// solutions

var forLoop = (array) => {
    for(let i = 0; i < 25; i++){
        array.push(`I am ${i} strange loop`)
    }
    return array
}

var whileLoop = (n) => {
    while(n > 0){
        console.log(--n)
    }
    return 'done'
}

var maybeTrue = () => {
    return Math.random() >= 0.5
}


var doWhileLoop = (array) => {
    do {
        array.pop()
    } while(array.length > 0 && maybeTrue())

    return array
}


