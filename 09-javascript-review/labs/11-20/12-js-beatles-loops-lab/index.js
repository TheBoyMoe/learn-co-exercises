// solutions

var theBeatlesPlay = (musicians, instruments) => {
    var sum = []
    for(let i = 0; i < musicians.length; i++){
        sum.push(`${musicians[i]} plays ${instruments[i]}`)
    }
    return sum
}

var johnLennonFacts = (array) => {
    let i = 0
    while(i < array.length){
        array[i] = `${array[i]}!!!`
        i++
    }
    return array
}

var iLoveTheBeatles = (n) => {
    var arr = []
    do {
        arr.push('I love the Beatles!')
        n--
    } while(n >= 0 && n < 15)
    return arr
}