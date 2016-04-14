class WelcomeController < ApplicationController
    def index
        if Test.all.blank?
            @tests = -1
        else
            @tests = Test.all
        end
        
    end
    
    def view_analytics
        if Test.all.blank?
            @tests = 0
        else
            @tests = Test.all
        end
        @novr_tests = []
        @vr_tests = []
        for t in 0..@tests.length - 1
            if @tests[t].video == 'novr'
                @novr_tests.push(@tests[t])
            else
                @vr_tests.push(@tests[t])
            end
        end
        
        #@table = [[1,-1,3],[2,-1,2],[3,-1,2],[20,20,-1],[12,14,-1],[10,15,-1],[20,14,-1],[20,15,-1],[10,11,-1],[15,16,-1],[10,-1,10],[1,1,-1],[1, -1, 2], [2, -1, 1],[0,-1,1],[14,14,-1]];
        #puts tests.length
        @tableVR = Array.new(@vr_tests.length){Array.new(2){nil}}
        @tableNoVR = Array.new(@novr_tests.length){Array.new(2){nil}}
        
        for i in 0..@vr_tests.length-1
            @id = @vr_tests[i].id;
            baseline_heart_avg = Heart.where(testid: @id, bort: 1).first.average
            test_heart_avg = Heart.where(testid: @id, bort: 2).first.average
            
            baseline_systolic_avg = Bloodpressure.where(testid: @id, bort: 1).first.average_systolic
            test_systolic_avg = Bloodpressure.where(testid: @id, bort: 2).first.average_systolic
            
            @tableVR[i][0] = test_heart_avg - baseline_heart_avg;

            @tableVR[i][1] = test_systolic_avg - baseline_systolic_avg;
        end
        
        for i in 0..@novr_tests.length-1
            @id = @novr_tests[i].id;
            baseline_heart_avg = Heart.where(testid: @id, bort: 1).first.average
            test_heart_avg = Heart.where(testid: @id, bort: 2).first.average
            
            baseline_systolic_avg = Bloodpressure.where(testid: @id, bort: 1).first.average_systolic
            test_systolic_avg = Bloodpressure.where(testid: @id, bort: 2).first.average_systolic
            
            @tableNoVR[i][0] = test_heart_avg - baseline_heart_avg;

            @tableNoVR[i][1] = test_systolic_avg - baseline_systolic_avg;
        end
        
    end
end
