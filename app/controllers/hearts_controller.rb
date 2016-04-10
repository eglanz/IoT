class HeartsController < ApplicationController
    def new
        @testid = params[:testid]
        @min = params[:min]
        @max = params[:max]
        @average = params[:average]
        @type = params[:type]
        
        @heart = Heart.where(testid: @testid, bort: @type).first
        if @heart == nil
            @heart = Heart.new(:testid => @testid, :min => @min, :max => @max, :average => @average, :bort => @type)
        else
            @heart.min = @min
            @heart.max = @max
            @heart.average = @average
            @heart.bort = @type
        end
        @heart.save
        render :json => 1
    end
end
