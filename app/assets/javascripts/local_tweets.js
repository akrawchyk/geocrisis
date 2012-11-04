var LocalTweets = LocalTweets || {};

LocalTweets.retrieveEarlier = function(max_id) {
  $('#tweets button').hide();
  $.ajax({
    url: '/local_tweets',
    data: {id: max_id},
    dataType: 'json',
    success: LocalTweets.addTweets
  });
};

LocalTweets.addTweets = function(newTweets) {
  var $tweetsElem = $('#tweets');

  $.each(newTweets, function(index, tweet) {
    var $newTweetsElem = $('<div/>', {
      'class': 'span12'
    });

    var $tweetElem = $('<div/>', {
      'class': 'tweet',
      data: {
        'tweet-id': tweet.id
      },
      appendTo: $newTweetsElem
    });

    var $tweetImg = $('<img/>', {
      'class': 'avatar',
      src: tweet.user.profile_image_url,
      appendTo: $tweetElem
    });

    var $tweetAuthor = $('<strong/>', {
      text: tweet.user.username,
      appendTo: $tweetElem
    });

    var $tweetContent = $('<div/>', {
      'class': 'content',
      text: tweet.text,
      appendTo: $tweetElem
    });

    $newTweetsElem.insertBefore($('#tweets button').parent());
  });

  $('#tweets button').show();
};
