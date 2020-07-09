class CommentsController < ApplicationController
    def my_comments
        @comment = current_user.comments
    end
end