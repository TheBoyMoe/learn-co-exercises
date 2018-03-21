// solution

var katzDeli = []

var takeANumber = (deliLine, patron) => {
    deliLine.push(patron)
    return `Welcome, ${patron}. You are number ${deliLine.length} in line.`
}

var nowServing = (deliLine) => {
  if (deliLine.length < 1) {
    return "There is nobody waiting to be served!"
  } else {
    var patron = deliLine.shift()
    return `Currently serving ${patron}.`
  }
}

var currentLine = (deliLine) => {
  if (deliLine.length < 1) {
    return "The line is currently empty."
  } else {
    var str = 'The line is currently: '
    for(let i = 0; i < deliLine.length; i++){
      str += `${i + 1}. ${deliLine[i]}, `
    }
    return str.slice(0, -2)
  }
}
