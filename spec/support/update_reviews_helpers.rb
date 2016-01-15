module UpdateReviewsHelpers
  def expect_fields_autopopulated
    review = find_field('Title').value
    expect(review).to eq users_review.title
    review = find_field('Review').value
    expect(review).to eq users_review.body
  end

  def fill_in_and_submit_form
    fill_in 'Title', with: 'I hated it so much'
    fill_in(
      'Review',
      with: 'So much that flames were coming out the sides of my face'
    )
    select '4', from: 'Rating'
    click_button 'Update Review'
  end
end
