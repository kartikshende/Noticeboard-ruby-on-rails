class CommentsController < ApplicationController
    before_action :find_message
    before_action :find_comment, only: [:edit, :update, :destroy]
    before_action :authenticate_user!
    def create
       
        @comment = @message.comments.create((comment_paramas))
        @comment.user_id = current_user.id
        if @comment.save
            redirect_to message_path(@message)
        else
            render "new"
        end
    end

    def edit
        
        
    end

    def update
        if @comment.update(comment_paramas)
            redirect_to message_path(@message)
        else
            render 'edit'
        end
    end
    
    def destroy
        @comment.destroy
        redirect_to message_path(@message)
    end


    def comment_paramas
        params.require(:comment).permit(:content)
    end

    def find_message
        @message = Message.find(params[:message_id])
    end
    
    def find_comment
        @comment = @message.comments.find(params[:id])
    end
end
