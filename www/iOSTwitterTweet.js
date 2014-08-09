var exec = require('cordova/exec');


var iOSTwitterTweet = function(status, callback) {
  var iOSTwitterTweetReturn = function (json) {
    var data = JSON.parse(json);

    if (data.error)
      return callback(data.error, null);

    return callback(null, data.tweet);
  }

  exec(iOSTwitterTweetReturn, iOSTwitterTweetReturn, 'iOSTwitterTweet', 'iOSTwitterTweet', [encodeURIComponent(status)]);
};

module.exports = iOSTwitterTweet;
