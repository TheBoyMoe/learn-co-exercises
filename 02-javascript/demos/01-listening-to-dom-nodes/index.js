"use strict";
document.addEventListener('DOMContentLoaded', function () {
    const divs = document.querySelectorAll('div');
    const input = document.querySelector('input');
    
    input.addEventListener('keydown', function (evt) {
        if(evt.which === 71) // 'g'
            return evt.preventDefault();
        console.log(evt.which); // capture the key clicked - displays keyco de
    });
    
    
    for(let i = 0; i < divs.length; i++){
      
        divs[i].addEventListener('click', bubble);
        
        // capturing events
        // divs[i].addEventListener('click', capture, true);
    }
    
    // clicking on one of the div's, and the event bubbles up the tree
    // until it ends at the DOM root, triggering any other listening nodes
    // Event capturing start's at the target's parent, and travels down the
    // tree until it reaches the target. By default events bubble, add true
    // as the 3rd arg to addEventListener function to trigger capturing
  
    // most of the time bubbling/capturing does not matter. If you want to
    // constrain an event to the target use stopPropagation()
    function bubble(evt) {
        evt.stopPropagation();
        console.log(`${this.firstChild.nodeValue.trim()} bubble`);
    }
  
  
    function capture(evt) {
      console.log(`${this.firstChild.nodeValue.trim()} capture`);
    }
    
});
