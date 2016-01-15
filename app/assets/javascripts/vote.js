$(document).ready(function() {
  $("body").on("click", ".upvote", function(event) {
    event.preventDefault();
    var urlID = $(this).attr("href");
    var delimeter = "/";
    var string = urlID;
    var splat = string.split(delimeter);
    var id = splat[2];

    $.ajax({
      type: "POST",
      url: "/api/v1/votes/upvote",
      dataType: "json",
      data: {
        review: {
          id: id
        }
      },
      success: function(response) {
        $("#vote-" + id).html("<li>" + response + "</li>");
      }
    });
    return false;
  });
});

$(document).ready(function() {
  $("body").on("click", ".downvote", function(event) {
    event.preventDefault();
    var urlID = $(this).attr("href");
    var delimeter = "/";
    var string = urlID;
    var splat = string.split(delimeter);
    var id = splat[2];
    $.ajax({
      type: "POST",
      url: "/api/v1/votes/downvote",
      dataType: "json",
      data: {
        review: {
          id: id
        }
      },
      success: function(response) {
        $("#vote-" + id).html("<li>" + response + "</li>");
      }
    });
    return false;
  });
});
