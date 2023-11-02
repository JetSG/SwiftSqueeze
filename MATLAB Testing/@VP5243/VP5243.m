classdef VP5243 < RobotBaseClass


    properties(Access = public)              
        plyFileNameStem = 'VP5243';
    end
    
    methods
%% Define robot Function 
        function self = VP5243(baseTr)
			self.CreateModel();
            if nargin < 1			
				baseTr = eye(4);				
            end
            self.model.base = self.model.base.T * baseTr;
            
            self.PlotAndColourRobot();         
        end

%% Create the robot model
        function CreateModel(self)   
            % Create the UR3 model mounted on a linear rail
            link(1) = Link('d',0.388,'a',0,'alpha',0,'qlim', deg2rad([-160 160]), 'offset',0);
            link(2) = Link('d',0.8,'a',0,'alpha',pi/2,'qlim', deg2rad([-120 120]), 'offset', 0); %pi/2
            link(3) = Link('d',0,'a',0,'alpha',0,'qlim',deg2rad([-128 136]),'offset', 0);
            link(4) = Link('d',0,'a',-0.54,'alpha',0,'qlim',deg2rad([-120 120]), 'offset',0);


            % Incorporate joint limits
            link(1).qlim = [-160 160]*pi/180;
            link(2).qlim = [-120 120]*pi/180;
            link(3).qlim = [-128 136]*pi/180;
            link(4).qlim = [-120 120]*pi/180;
           
        

            
            self.model = SerialLink(link,'name',self.name);
        end
     
    end
end