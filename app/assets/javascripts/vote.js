$(".review-upvotes").on("click", function(e) {
  e.preventDefault();

  var id = $this.data('review-id')

  $.ajax({
    type: "POST",
    url: "/api/v1/votes/reviews/" + id + "/upvote",
    dataType: "json",
    success: function(response) {
      $(".upvote-count").html("<p> Upvotes: " + response + "</p>");
    }
  });
  return false
});
