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

The MIT License
