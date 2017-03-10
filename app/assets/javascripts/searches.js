
$('.modal').modal({
     dismissible: true, // Modal can be dismissed by clicking outside of the modal
     opacity: 0.5, // Opacity of modal background
     inDuration: 300, // Transition in duration
     outDuration: 200, // Transition out duration
     startingTop: '4%', // Starting top style attribute
     endingTop: '10%', // Ending top style attribute
     ready: function(modal, trigger) { // Callback for Modal open. Modal and trigger parameters available.
       alert("Ready");
       console.log(modal, trigger);
     },
     complete: function() { alert('Closed'); } // Callback for Modal close
   }
 );
 $( document ).on('turbolinks:load',function(){
   // the "href" attribute of .modal-trigger must specify the modal ID that wants to be triggered
   $('.modal').modal();
   $('#modal1').modal('open');
   $('#modal1').modal('close');

  //  console.dir($('#signUpModalBtn'));

   $('#signUpModalBtn').click(function(e){
     e.preventDefault();
     console.log('worked');
   });
 });
