require 'csv'

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
        
         header = "Id,ChangeHR,ChangeBP"
         file = "train.csv"
         
         CSV.open( file, 'w' ) do |writer|
             writer << ["Id","ChangeHR","ChangeBP"]
            for y in 0..@novr_tests.length-1
                writer << [@novr_tests[y].id, @tableNoVR[y][0], @tableNoVR[y][1]]
            end
            for s in 0..@vr_tests.length-1
                writer << [@vr_tests[s].id, @tableVR[s][0], @tableVR[s][1]]
            end
        end
        args1 = "train.csv"
        args2 = "train.csv"
        output = `java -jar VRCluster.jar #{args1} #{args2}`
        outputs = output.split("\n");
        cluster1Size = 0;
        cluster0Size = 0;
        outputs.each do |o|
            arr = o.split(",")
            if arr[1] == 1 || arr[1] == "1"
                cluster1Size = cluster1Size + 1
            else
                cluster0Size = cluster0Size + 1
            end
        end
        
        @tableCluster1 = Array.new(cluster1Size){Array.new(2){nil}}
        @tableCluster0 = Array.new(cluster0Size){Array.new(2){nil}}
        
        cluster1Counter = 0;
        cluster0Counter = 0;
        outputs.each do |o|
           arr = o.split(",")
           if arr[1] == 1 || arr[1] == "1"
                @tableCluster1[cluster1Counter][0] = arr[2].to_f
                @tableCluster1[cluster1Counter][1] = arr[3].to_f
                cluster1Counter = cluster1Counter + 1
            else
                @tableCluster0[cluster0Counter][0] = arr[2].to_f
                @tableCluster0[cluster0Counter][1] = arr[3].to_f
                cluster0Counter = cluster0Counter + 1
            end
        end
        
        puts "HERE"
    end
end
