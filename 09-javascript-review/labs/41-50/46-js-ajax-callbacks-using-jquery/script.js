$(document).ready(function () {
  // first arg is the url, 2nd is the callback

  //$.get('sentence.html', function (response) {
    // get the element and insert the response
    //$('#sentences').html(response)
  //})
  const url = "https://api.github.com/repos/rails/rails/commits?sha=82885325e04d78fb7ec608a4670164d842d23078";

  // $.get(url, function (response) {
  //   console.log(`Success`)
  //   console.log(response)
  // }).fail(function (error) { // this callback will be executed only if an error occurs
  //   console.log(`Failure: ${error}`)
  // })

  // newer syntax
  $.get(url)
    .done((data)=>{
      console.log("Success")
      console.log(data)
    })
    .fail((error)=>{
      console.log(`Failure ${error}`)
    })
})