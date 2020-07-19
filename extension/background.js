chrome.browserAction.onClicked.addListener(function(tab) {
  var url = 'https://www.velloa.fr/articles/from_url';
  var xhr = new XMLHttpRequest();
  xhr.open('POST', url, true);
  xhr.send('article[url]=' + tab.url);
});
