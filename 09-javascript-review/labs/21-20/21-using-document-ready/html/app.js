// ensure that the page has loaded the html prior to running the js
$(document).ready(function(){

    // using jquery
    $("#jq-content").append(" Organically grow the holistic world view of disruptive innovation via workplace diversity and empowerment.")

    // using js
    let p = document.getElementById("js-content")
    p.append(" is on the runway heading towards a streamlined cloud solution. User generated content in real-time will have multiple touchpoints for offshoring.")

    // add image using jquery
    $("#jq-image").append("<img src='https://s3.amazonaws.com/learn-verified/painting-with-dog.gif' alt='image set using jquery'>")

    // add image using js
    let image_wrap = document.getElementById("js-image")
    let image = document.createElement("img")
    image.setAttribute("src", "https://s3.amazonaws.com/learn-verified/painting-with-dog.gif")
    image.setAttribute("alt", "image set using js")
    image_wrap.append(image)

})

