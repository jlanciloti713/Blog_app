$(document).ready(function() {
  var commentBox = $("#comment-box");
  var commentButton = $("#comment-button");
  var token = $('meta[name="csrf-token"]').prop('content');
  var blogPostID = $("#blog-post-id").prop("value");
  var commentsContainer = $("#comments-container");

  commentButton.on("click", function(event) {
    even.preventDefault();
  });

  $.ajax({
    type: "POST",
    url: "/comments",
    headers: {'X-CSRF-TOKEN': token}, 
    data: {blog_post_id: blogPostID, content: commentBox.prop("value")},
    datatype: 'json',
    success: function(response) {
      commentsContainer.append(
        `<div class="comment">
         <h5>By ${response.user.email}</h5> 
         <p> ${response.content}</p>
         <a href='/comments/${response.id}' rel="nofollow" data-method="delete">Delete Comemnt</a>
         </div>`
        );
      },
    error: function(response) {
      console.log(response);
    }
  });




});

