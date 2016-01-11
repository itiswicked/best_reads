class ReviewMailer < ApplicationMailer
  def new_review(review)
    @review = review

    mail(
      to: review.book.user.email,
      subject: "New Review for #{review.book.title}!"
    )
  end
end
