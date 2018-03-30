
// Stub out the jquery get() request
function getCharacters(callback) {
  $.get('http://api.example.com/characters', callback);
}


// Mocks

// we have a mechanism to save user preference's
const storage = {
  saveRemainLoggedInPreference(remainLoggedIn) {
    // Save the `remainLoggedIn` preference in some way
  },
  saveLanguagePreference: (language) => {
    // Save the `language` preference in some way
  }
};

function sendPrefsToStorage({ remainLoggedIn, language }) {
  storage.saveRemainLoggedInPreference(remainLoggedIn);
  storage.saveLanguagePreference(language);
}

$('#prefs-submit').on('click', function () {
  const remainLoggedIn = $('#remain-logged-in').is(':checked');
  const language = $('#language-selector').val();
  sendPrefsToStorage({ remainLoggedIn, language });
});