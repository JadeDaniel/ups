class AuthorizedController < ApplicationController
    before_action :authorized

    def authorized
        redirect_to '/welcome' unless logged_in?
    end
    
end
