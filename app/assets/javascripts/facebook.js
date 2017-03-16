(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.8&appId=194677921017576";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));

$(document).on('turbolinks:load', function() {
  $('.share_button').click(function(e) {
    e.preventDefault();
    var href = $(this).data('href');
    if (window.FB) {
      console.log('click');
      FB.ui({
        method: 'share',
        href: href,
        quote: "I just volunteered with B Good, now it's your turn.  Visit their site and pick an opportunity.  Then, tag the next person!",
        hashtag: '#bgood'
      }, function(response){
        // Debug response (optional)
        // console.log(response);
      });
    }
  });
});
