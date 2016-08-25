class ReviewsController < ApplicationController

  def create
    @review = current_user.reviews.create(review_params)

    #redirect to review of the same room.
    redirect_to @review.room
  end

  def destroy
   #get review based on the id
    @review = Review.find(params[:id])


    #get the room of that review
    room = @review.room

    #destroy review
    @review.destroy

    #redirect back to the room
    redirect_to room

  end




  private

  def review_params
    params.require(:review).permit(:comment, :star, :room_id)
  end

end