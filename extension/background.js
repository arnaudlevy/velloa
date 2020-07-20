chrome.browserAction.onClicked.addListener(function(tab) {
  var url = 'https://www.velloa.fr/articles/from_url.json',
      url = 'http://localhost:3000/articles/from_url.json',
      params = 'article[url]=' + tab.url,
      xhr = new XMLHttpRequest();
  chrome.tabs.executeScript(tab.id, {
    code: 'new XMLSerializer().serializeToString(document);'
  }, function(results) {
      var html = results[0];
      params += '&article[html]=' + encodeURIComponent(html);
      xhr.open('POST', url, true);
      xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
      xhr.onreadystatechange = function () {
        if (xhr.readyState === 4) {
          if (xhr.status === 200) {
            alert('Saved');
          } else {
            alert('Error');
          }
        }
      };
      xhr.send(params);
  });
});
