// Activate dropdowns for materializecss
$( document ).ready(function(){
  $(".dropdown-button").dropdown();
});

// Activate modals for materializecss
$(document).ready(function(){
  // the "href" attribute of .modal-trigger must specify the modal ID that wants to be triggered
  $('.modal-trigger').leanModal();
});
