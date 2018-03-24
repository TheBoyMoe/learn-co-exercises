"use strict"

const batteryBatches = [4, 5, 3, 4, 4, 6, 5];
var totalBatteries = batteryBatches.reduce((sum, batchSize)=>{
  return sum + batchSize
}, 0)


////////////////////////////////////////////////////////////////
const monologueLines = [
  'Who are you talking to right now?',
  'Who is it you think you see?',
  'Do you know how much I make a year?',
  'I mean, even if I told you, you wouldn\'t believe it.',
  'Do you know what would happen if I suddenly decided to stop going into work?',
  'A business big enough that it could be listed on the NASDAQ goes belly up.',
  'Disappears!',
  'It ceases to exist without me.',
  'No, you clearly don\'t know who you\'re talking to, so let me clue you in.',
  'I am not in danger, Skyler.',
  'I am the danger.',
  'A guy opens his door and gets shot and you think that of me?',
  'No.',
  'I am the one who knocks!'
];

var wordCountMap = monologueLines.reduce((obj, line, i, array)=>{
  var wordCount = String(line.split(' ').length);
  obj[wordCount] = obj[wordCount] || 0
  obj[wordCount]++
  return obj
}, {})
