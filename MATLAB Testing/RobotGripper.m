classdef RobotGripper < handle
    %ROBOTCOWS A class that creates a herd of robot cows
	%   The cows can be moved around randomly. It is then possible to query
    %   the current location (base) of the cows.     RobotCows
    
    %#ok<*TRYNC>    

    properties (Constant)
        %> Max height is for plotting of the workspace
        maxHeight = 10;
    end
    
    properties
        %> Number of cows
        gripperCount = 2;
        
        %> A cell structure of \c gripperCount cow models
        gripperModel;
        
        %> paddockSize in meters
        paddockSize = [10,10];        
        
        %> Dimensions of the workspace in regard to the padoc size
        workspaceDimensions;
    end
    
    methods
        %% ...structors
        function self = RobotGripper(gripperCount)
            if 0 < nargin
                self.gripperCount = gripperCount;
            end
            
            self.workspaceDimensions = [-self.paddockSize(1)/2, self.paddockSize(1)/2 ...
                                       ,-self.paddockSize(2)/2, self.paddockSize(2)/2 ...
                                       ,0,self.maxHeight];

            % Create the required number of cows
            for i = 1:self.gripperCount
                self.gripperModel{i} = self.GetgripperModel(['Assignment1Gripper',num2str(i)]);
                % Random spawn
                basePose = SE3(SE2((2 * rand()-1) * self.paddockSize(1)/2 ...
                                         , (2 * rand()-1) * self.paddockSize(2)/2 ...
                                         , (2 * rand()-1) * 2 * pi));
                self.gripperModel{i}.base = basePose;
                
                 % Plot 3D model
                plot3d(self.gripperModel{i},0,'workspace',self.workspaceDimensions,'view',[-30,30],'delay',0,'noarrow','nowrist');
                % Hold on after the first plot (if already on there's no difference)
                if i == 1 
                    hold on;
                end
            end

            axis equal
            if isempty(findobj(get(gca,'Children'),'Type','Light'))
                camlight
            end 
        end
    end
    
    methods (Static)
        %% GetgripperModel
        function model = GetgripperModel(name)
            if nargin < 1
                name = 'HalfSizedRedGreenBrick';
            end
            [faceData,vertexData] = plyread('HalfSizedRedGreenBrick.ply','tri');
            link1 = Link('alpha',pi/2,'a',0,'d',0.1,'offset',0);
            model = SerialLink(link1,'name',name);
            
            % Changing order of cell array from {faceData, []} to 
            % {[], faceData} so that data is attributed to Link 1
            % in plot3d rather than Link 0 (base).
            model.faces = {[], faceData};

            % Changing order of cell array from {vertexData, []} to 
            % {[], vertexData} so that data is attributed to Link 1
            % in plot3d rather than Link 0 (base).
            model.points = {[], vertexData};
        end
    end    
end