class BloodpressuresController < ApplicationController
    def new
        @testid = params[:testid]
        @s_min = params[:min_systolic]
        @s_max = params[:max_systolic]
        @s_average = params[:average_systolic]
        @d_min = params[:min_diastolic]
        @d_max = params[:max_diastolic]
        @d_average = params[:average_diastolic]
        @type = params[:type]
        
        @bp = Bloodpressure.where(testid: @testid, bort: @type).first
        if @bp == nil
            @bp = Bloodpressure.new(:testid => @testid, :min_systolic => @s_min, :max_systolic => @s_max, :average_systolic => @s_average, :min_diastolic => @d_min, :max_diastolic => @d_max, :average_diastolic => @d_average, :bort => @type)
        else
            @bp.min_systolic = @s_min
            @bp.max_systolic = @s_max
            @bp.average_systolic = @s_average
            @bp.min_diastolic = @d_min
            @bp.max_diastolic = @d_max
            @bp.average_diastolic = @d_average
            @bp.bort = @type
        end
        @bp.save
        
        render :json => 1
    end
end
