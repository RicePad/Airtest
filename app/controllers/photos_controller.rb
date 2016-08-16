class PhotosController < ApplicationController

  #Destroy action for room images using AJAX
  def destroy

    # grabs the image id shows it in the room
    @photo = Photo.find(params[:id])
    room = @photo.room

    @photo.destroy
    @photos = Photo.where(room_id: room.id)

    respond_to :js #after destroy action occurs this one responds to ajax in photos/destroy.js.erb
  end
end