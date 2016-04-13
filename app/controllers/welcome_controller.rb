class WelcomeController < ApplicationController
    def index
        if Test.all.blank?
            @tests = nil
        else
            @tests = Test.all
        end
        
    end
    
    def view_analytics
        
    end
end
