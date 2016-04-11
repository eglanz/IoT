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
            @average_sbaseline_blood = "Waiting for Average Baseline Blood Pressure"
            @minimum_sbaseline_blood = "Waiting for Minimum Baseline Blood Pressure"
            @maximum_sbaseline_blood = "Waiting for Maximum Baseline Blood Pressure"
            @average_dbaseline_blood = "Waiting for Average Baseline Blood Pressure"
            @minimum_dbaseline_blood = "Waiting for Minimum Baseline Blood Pressure"
            @maximum_dbaseline_blood = "Waiting for Maximum Baseline Blood Pressure"
        else
            if @baseline_heart != nil
                
                @status = Teststatus.where(testid: @test.id).first
                if @status.status < 3
                    @status.status = 3
                    @status.save
                end
            end
            @average_sbaseline_blood = @baseline_bloodpressure.average_systolic
            @minimum_sbaseline_blood = @baseline_bloodpressure.min_systolic
            @maximum_sbaseline_blood = @baseline_bloodpressure.max_systolic
            @average_dbaseline_blood = @baseline_bloodpressure.average_diastolic
            @minimum_dbaseline_blood = @baseline_bloodpressure.min_diastolic
            @maximum_dbaseline_blood = @baseline_bloodpressure.max_diastolic
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
            @average_stest_blood = "Waiting for Average Test Blood Pressure"
            @minimum_stest_blood = "Waiting for Minimum Test Blood Pressure"
            @maximum_stest_blood = "Waiting for Maximum Test Blood Pressure"
            @average_dtest_blood = "Waiting for Average Test Blood Pressure"
            @minimum_dtest_blood = "Waiting for Minimum Test Blood Pressure"
            @maximum_dtest_blood = "Waiting for Maximum Test Blood Pressure"
        else
            if @test_heart != nil
                
                @status = Teststatus.where(testid: @test.id).first
                if @status.status < 7
                    @status.status = 7
                    @status.save
                end
            end
            @average_stest_blood = @test_bloodpressure.average_systolic
            @minimum_stest_blood = @test_bloodpressure.min_systolic
            @maximum_stest_blood = @test_bloodpressure.max_systolic
            @average_dtest_blood = @test_bloodpressure.average_diastolic
            @minimum_dtest_blood = @test_bloodpressure.min_diastolic
            @maximum_dtest_blood = @test_bloodpressure.max_diastolic
        end
           
        
    end
    
    def start
        @value = -1;
        if Startstatus.all.blank? || Startstatus.find(1).start == -1
            @value = -1;
        else
            @value = Startstatus.find(1).start
        end
        render :json => @value
    end
    
    def set_start
        @value = params[:test]
        
        if Startstatus.all.blank?
          status = Startstatus.new(:id => 1, :start => @value)
        else
            status = Startstatus.find(1)
            status.start = @value
        end
        status.save
        
        render :json => 1
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
