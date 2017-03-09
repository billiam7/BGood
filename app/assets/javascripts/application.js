// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
// $('.button-collapse').sideNav({
//      menuWidth: 300, // Default is 300
//      edge: 'right', // Choose the horizontal origin
//      closeOnClick: true, // Closes side-nav on <a> clicks, useful for Angular/Meteor
//      draggable: true // Choose whether you can drag to open on touch screens
//    }
//  );
(function($){
  $(function(){

    $('.button-collapse').sideNav();
    $('.parallax').parallax();

  }); // end of document ready
})(jQuery); // end of jQuery name space

$('.modal').modal({
     dismissible: true, // Modal can be dismissed by clicking outside of the modal
     opacity: .5, // Opacity of modal background
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
 $(document).ready(function(){
   // the "href" attribute of .modal-trigger must specify the modal ID that wants to be triggered
   $('.modal').modal();
   $('#modal1').modal('open');
   $('#modal1').modal('close');
 });
