var currentLanguage = function(){
  return docCookies.getItem('lang')
}

var setCurrentLanguage = function(lang){
  docCookies.setItem('lang', lang)
}



// return the translated text for a given key and language
var translate = function(key, lang){

  if(!lang || lang == 'undefined'){
    lang = 'default'
  }

  // Checks if key exists and if lang exists, if they don't then
  // they will be undefined, which is considered false by Javascript
  if(translations[key] && translations[key][lang]){
    return translations[key][lang]
  }

  // no need to return anything if there wasn't a translation,
  // the value that comes back will just be undefined
}


// add the default translation for an element into the translations object
var setDefaultTranslation = function(element){

  key = element.data('translate_key')

  // if the key exists, and we haven't already added a default value...
  if(translations[key] && !translations[key]['default']){

    // then use the current contents of this element as the 'default' translation
    // we add it to the object with this code so that it isn't 'hard-coded' into
    // the translations object, which would mean duplicating all the text from the
    // actual HTML
    translations[key]['default'] = element.html()
  }

}


var doLocalization = function(){


  // go through each item that has a translate_key and translate it
  $('[data-translate_key]').each(function(){

    setDefaultTranslation($(this))

    translation = translate($(this).data('translate_key'), currentLanguage())

    // if the translation doesn't exist, the value returned will be undefined
    // conveniently, if you pass an undefined value into jQuery's html() function
    // it doesn't do anything, which is exactly what we want in that case

    // if there was a translation available, then we get back the translated text
    // which is used to replace the contents of the tag to be translated
    $(this).html(translation)

  })

}