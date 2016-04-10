class BloodpressuresController < ApplicationController
    def new
        @testid = params[:testid]
        @min = params[:min]
        @max = params[:max]
        @average = params[:average]
        @type = params[:type]
        
        @heart = Bloodpressure.where(testid: @testid).first
        if @heart == nil
            @heart = Bloodpressure.new(:testid => @testid, :min => @min, :max => @max, :average => @average, :bort => @type)
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
