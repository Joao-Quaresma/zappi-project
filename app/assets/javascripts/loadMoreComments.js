var Clicked;
 $( document ).ready(function() {
  $('body').on('click', '.more-comments', function() {
     $(this).on('ajax:success', function(event, data, status, xhr) {
       var postId = $(this).data("post-id");
       $("#comments_" + postId).html(data);
      Clicked = true;
     });
   });
 });

function DestroyComments(){
  $('.delete-comment').click( function() {
    Append.id = this;
    Append.post_id = $(this).data("post-id");
    Append.comment_count = $(this).data("value");
  }); 
}

$( document ).ready(function() {
  ClickableCommentsLink();
  DestroyComments();
  $('.comment_content').click (function(){
  	Append.id = this;
  	Append.post_id = $(this).data("post-id");
  	if (Append.comment_count == undefined){ Append.comment_count = $(this).data("value"); }
  	if(Append.comment_count < 4){ Append.comment = true; Append.link = false; } 
  	else if(Append.comment_count == 4){ Append.comment = false; Append.link = true; } 
  	else if(Append.comment_count > 4){ Append.comment = false; Append.link = false;  } 
  })
});