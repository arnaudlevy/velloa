chrome.browserAction.onClicked.addListener(function(tab) {
  var url = 'https://www.velloa.fr/articles/from_url';
  var xhr = new XMLHttpRequest();
  xhr.open('POST', url, true);
  xhr.onreadystatechange = function (event) {
    if (event.target.readyState === 4) {
        if (event.target.status === 200) {
          alert('Saved');
        } else {
          alert('Error');
        }
    }
  };
  xhr.send('article[url]=' + tab.url);
});
