//define functions here
function getIt() {
    $('p').on('click', function (e) {
        window.alert('Clicked on p tag')
    })
}

function frameIt() {
    $('img').on('load', function (e) {
        $(this).addClass('tasty')
    })
}

function pressIt() {
   $(document).on('keydown', function (key) {
       if(key.which === 71){
           window.alert("G key was pressed")
       }
   })
}

function submitIt() {
    $('form').on('submit', function (e) {
        window.alert("Your form is going to be submitted now.")
    })
}

$(document).ready(function(){

    // call functions here
    getIt()
});
