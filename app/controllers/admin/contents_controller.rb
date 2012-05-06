class Admin::ContentsController < ApplicationController
 layout 'admin/administration'

  before_filter :login_required
			
	def edit
	  @content = Content.find(params[:id])
	end

	def update
    @content = Content.find(params[:id])
    if @content.update_attributes(params[:content])
      flash[:notice] = "Content was successfully updated."
      redirect_to edit_admin_content_path(@content)
    else
      render :action => :edit
    end
	end

end
