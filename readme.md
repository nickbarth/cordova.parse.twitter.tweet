## Cordova iOS Twitter Tweet

## About this Plugin

Sent Twitter tweet for an authorized iOS device. Supports iOS Versions 6.0 and up only.

## Using the Plugin

Example:

```
window.iOSTwitterTweet("New Tweet! : )", function (err, tweet) {
  if (err) return alert(err);
  console.log('tweet sent', tweet);
});
```

## Adding the Plugin ##

```bash
cordova plugin add https://github.com/nickbarth/cordova.parse.twitter.tweet.git
```

## LICENSE ##
The CC0 License

[![CC0](http://i.creativecommons.org/l/zero/1.0/88x31.png)](http://creativecommons.org/publicdomain/zero/1.0/)
