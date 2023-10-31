classdef KinovaLink6 < RobotBaseClass

    properties(Access = public)
        plyFileNameStem = 'Kinova';
    end

    methods
        function self = KinovaLink6(baseTr)
			self.CreateModel();
            if nargin == 1			
				self.model.base = self.model.base.T * baseTr * trotz(pi/2);
            end
            
            self.PlotAndColourRobot();         
        end

        function CreateModel(self)
            %Create the Kinova Link 6 model
<<<<<<< HEAD
            link(1) = Link('d',+0.1375+0.0515, 'a',-0.110244, 'alpha',pi/2, 'offset',-pi/2);
            link(2) = Link('d',0.06925, 'a',0.485, 'alpha',0, 'offset',pi/2);
            link(3) = Link('d',-0.0917, 'a',0, 'alpha',pi/2, 'offset',-pi/2);
            link(4) = Link('d',-0.23975-0.0917, 'a',0, 'alpha',pi/2, 'offset',pi);
            link(5) = Link('d',+0.078422+0.06296, 'a',-0.086, 'alpha',pi/2, 'offset',pi/2);
            link(6) = Link('d',0.092+0.08708, 'a',0, 'alpha',0, 'offset',0);
            % link(1) = Link('d',0, 'a',0, 'alpha',0, 'offset',0);
            % link(2) = Link('d',1, 'a',0, 'alpha',0, 'offset',0);
=======
            link(1) = Link('d',0.0515, 'a',0.0, 'alpha',pi, 'offset',0);
            link(2) = Link('d',-0.1375, 'a',0.11024, 'alpha',-pi/2, 'offset',0); %offset in cad by 69.25 mm along z
            link(3) = Link('d',0.485, 'a',0, 'alpha',pi, 'offset',0);
            % link(4) = Link('d',0.15216, 'a',0.09170, 'alpha',0, 'offset',0);
            % link(5) = Link('d',0.23975, 'a',-0.06296, 'alpha',pi/2, 'offset',0);
            % link(6) = Link('d',0.086, 'a',-0.07692, 'alpha',0, 'offset',0);
            %link(1) = Link('d',0, 'a',0, 'alpha',0, 'offset',0);
            %link(2) = Link('d',0.1375, 'a',0.11024, 'alpha',pi/2, 'offset',0);
>>>>>>> b37769249065c6f042001a1c722979d1ca69aec1
            % link(3) = Link('d',0, 'a',0, 'alpha',0, 'offset',0);
            % link(4) = Link('d',0, 'a',0, 'alpha',0, 'offset',0);
            % link(5) = Link('d',0, 'a',0, 'alpha',0, 'offset',0);
            % link(6) = Link('d',0, 'a',0, 'alpha',0, 'offset',0);
            %Set the joint limits
         

            self.model = SerialLink(link,'name', self.name);
            
        end
    end
end