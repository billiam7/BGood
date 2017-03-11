 $( document ).on('turbolinks:load',function(){
   $('.modal').modal({
        dismissible: true, // Modal can be dismissed by clicking outside of the modal
        opacity: 0.5, // Opacity of modal background
        inDuration: 300, // Transition in duration
        outDuration: 200, // Transition out duration
        startingTop: '4%', // Starting top style attribute
        endingTop: '10%', // Ending top style attribute
        ready: function(modal, trigger) { // Callback for Modal open. Modal and trigger parameters available.
          var $trigger = $(trigger);
          // console.log($trigger.data());
          var oppid = $trigger.data('oppid');
          var oppName = $trigger.data('name');
          var oppOrg = $trigger.data('organization');
          var oppDate = $trigger.data('date');
          var oppTime = $trigger.data('time');
          var oppLink = $trigger.data('link');
            console.log("oppOrg: ", oppOrg, "oppDate:", oppDate, "oppTime:", oppTime, "oppLink:", oppLink);
            console.log($trigger.data);
          $('.signup-button').attr('href', $('.signup-button').attr('href') +
            "?oppid=" + oppid + "&name=" + oppName + "&organization=" + oppOrg + "&date=" + oppDate + "&time=" + oppTime + "&link=" + oppLink);
        },
        // complete: function() { console.log('Closed'); } // Callback for Modal close
      }
    );

   // the "href" attribute of .modal-trigger must specify the modal ID that wants to be triggered
  //  $('.modal').modal();
  //  $('#modal1').modal('open');
  //  $('#modal1').modal('close');
  //
  // //  console.dir($('#signUpModalBtn'));
  //a
  //  $('#signUpModalBtn').click(function(e){
  //    e.preventDefault();
  //    console.log('worked');
  //  });

 });
