document.addEventListener("turbolinks:load", function() {

  $("#announcements-bookmark-list").sortable({
    update: function(e, ui) {
      $.ajax({
        url: $(this).data("url"),
        type: "PATCH",
        data: $(this).sortable('serialize'),
      });
    }
  });

});