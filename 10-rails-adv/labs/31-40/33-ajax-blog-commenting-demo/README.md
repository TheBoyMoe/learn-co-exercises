# README


## Requirements

1. the abilityto load a posts comments via AJAX
  - we need to capture the click event of the 'Load Comment' link and use it to launch the ajax request
    - bind the ajax request to the link element
    - prevent the default browser behaviour so it no longer follows the link(loads the page)
    - launch the ajax request to get the data
    - add that data to the DOM

2. the ability to submit a new comment via AJAX


## Overview

AJAX allows a browser to make requests behind the scenes without locking up the browser while waiting for the reply from the server or requiring a page refresh and redrawing the whole DOM. Ajax uses asynchronous requests as opposed to synchronous requests where the user must wait for the reply before carrying on. This allows the user to carry on using the browser, so improving the user's experience.


