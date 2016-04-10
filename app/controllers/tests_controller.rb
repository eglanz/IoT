class TestsController < ApplicationController
    def index
        @tests = Test.all
    end
   
    def new
    end
    
    def show
        @test = Test.find(params[:id])
        @baseline_heart = Heart.where(testid: @test.id, bort: 1).first
        if @baseline_heart == nil
            @average_baseline_heart = "Waiting for Average Baseline Heart Rate"
            @minimum_baseline_heart = "Waiting for Minimum Baseline Heart Rate"
            @maximum_baseline_heart = "Waiting for Maximum Baseline Heart Rate"
        else
            
            @status = Teststatus.where(testid: @test.id).first
            if @status.status < 2
                @status.status = 2
                @status.save
            end
            @average_baseline_heart = @baseline_heart.average
            @minimum_baseline_heart = @baseline_heart.min
            @maximum_baseline_heart = @baseline_heart.max
        end
        @baseline_bloodpressure = Bloodpressure.where(testid: @test.id, bort: 1).first
        
        if @baseline_bloodpressure == nil
            @average_baseline_blood = "Waiting for Average Baseline Blood Pressure"
            @minimum_baseline_blood = "Waiting for Minimum Baseline Blood Pressure"
            @maximum_baseline_blood = "Waiting for Maximum Baseline Blood Pressure"
        else
            if @baseline_heart != nil
                
                @status = Teststatus.where(testid: @test.id).first
                if @status.status < 3
                    @status.status = 3
                    @status.save
                end
            end
            @average_baseline_blood = @baseline_bloodpressure.average
            @minimum_baseline_blood = @baseline_bloodpressure.min
            @maximum_baseline_blood = @baseline_bloodpressure.max
        end
        
        
        @test_heart = Heart.where(testid: @test.id, bort: 2).first
        if @test_heart == nil
            @average_test_heart = "Waiting for Average Test Heart Rate"
            @minimum_test_heart = "Waiting for Minimum Test Heart Rate"
            @maximum_test_heart = "Waiting for Maximum Test Heart Rate"
        else
            
            @status = Teststatus.where(testid: @test.id).first
            if @status.status < 5
                @status.status = 5
                @status.save
            end
            @average_test_heart = @test_heart.average
            @minimum_test_heart = @test_heart.min
            @maximum_test_heart = @test_heart.max
        end
        @test_bloodpressure = Bloodpressure.where(testid: @test.id, bort: 2).first
        
        if @test_bloodpressure == nil
            @average_test_blood = "Waiting for Average Test Blood Pressure"
            @minimum_test_blood = "Waiting for Minimum Test Blood Pressure"
            @maximum_test_blood = "Waiting for Maximum Test Blood Pressure"
        else
            if @test_heart != nil
                
                @status = Teststatus.where(testid: @test.id).first
                if @status.status < 6
                    @status.status = 6
                    @status.save
                end
            end
            @average_test_blood = @test_bloodpressure.average
            @minimum_test_blood = @test_bloodpressure.min
            @maximum_test_blood = @test_bloodpressure.max
        end
           
        
    end
    
    def status
        @id = params[:test];
        @status = Teststatus.where(testid: @id).first
        if @status == nil
            @status = Teststatus.new(testid: @id, status: 0)
        end
        @status.save
        render :json => @status.status
    end
    
    def baseline_clicked
        @id = params[:test];
        @status = Teststatus.where(testid: @id).first
        if @status == nil
            @status = Teststatus.new(testid: @id, status: 1)
        end
        @status.status = 1
        @status.save
    end
    
    def test_clicked
        @id = params[:test];
        @status = Teststatus.where(testid: @id).first
        if @status == nil
            @status = Teststatus.new(testid: @id, status: 4)
        end
        @status.status = 4
        @status.save
    end
    def create
        @test = Test.new(test_params)
        
        @test.save
        redirect_to :action => 'show', :id => @test.id
    end
    
    def edit
        @test = Test.find(params[:id])
    end
    
    def update
       @test = Test.find(params[:id])
       if @test.update_attributes(test_params)
           redirect_to :action => 'show', :id => @test.id
       end
    end
    
    private
        def test_params
            params.require(:test).permit(:patient_name, :video)
        end
end
