class UseraudiofilesController < ApplicationController

  def new
    @audio_file = Useraudiofile.new
  end

  def create
    # byebug
    p '*' * 30
    p params
    @user = current_user



    # debugger
    @audio_file = Useraudiofile.new(
      media_file_name: params[:useraudiofile][:media][0].original_filename,
      media_content_type: params[:useraudiofile][:media][0].content_type
      )
    # @audio_file = Useraudiofile.new(audio_params)
    @audio_file.user_id = current_user.id
    if @audio_file.save
      redirect_to user_path(@user)
    else
      @errors = @post.errors.full_messages
      render :new
    end
  end

  private
  def audio_params
    params.require(:useraudiofile).permit(:media)
    # [#<ActionDispatch::Http::UploadedFile:0x007fefdcab0be8
    #   @tempfile=#<Tempfile:/var/folders/j4/_7fjtgq96_d1msbk33j7w0xh0000gn/T/RackMultipart20170410-38396-19ibq35.mp3>,
    #   @original_filename="STC_Down_The_Road.mp3",
    #   @content_type="audio/mp3",
    #   @headers="Content-Disposition: form-data; name=\"useraudiofile[media][]\"; filename=\"STC_Down_The_Road.mp3\"\r\nContent-Type: audio/mp3\r\n">]
end

end
