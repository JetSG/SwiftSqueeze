classdef KinovaLink6 < RobotBaseClass

    properties(Access = public)
        plyFileNameStem = 'Kinova';
    end

    methods
        function self = KinovaLink6(baseTr)
            self.CreateModel()
            if nargin < 1
                baseTr = eye(4);
            end
            self.model.base = self.model.base.T * baseTr;
            self.PlotAndColourRobot();
        end

        function CreateModel(self)
            %Create the Kinova Link 6 model
            link(1) = Link('d',0.0515, 'a',0.0, 'alpha',pi, 'offset',0);
            link(2) = Link('d',-0.1375, 'a',0.110244, 'alpha',3*pi/2, 'offset',0);
            link(3) = Link('d',0.485, 'a',0, 'alpha',3*pi/2, 'offset',0);
            link(4) = Link('d',0.15216, 'a',0.09170, 'alpha',0, 'offset',0);
            link(5) = Link('d',0.23975, 'a',-0.06296, 'alpha',pi/2, 'offset',0);
            link(6) = Link('d',0.086, 'a',-0.07692, 'alpha',0, 'offset',0);
            % link(1) = Link('d',0, 'a',0, 'alpha',0, 'offset',0);
            % link(2) = Link('d',1, 'a',0, 'alpha',0, 'offset',0);
            % link(3) = Link('d',0, 'a',0, 'alpha',0, 'offset',0);
            % link(4) = Link('d',0, 'a',0, 'alpha',0, 'offset',0);
            % link(5) = Link('d',0, 'a',0, 'alpha',0, 'offset',0);
            % link(6) = Link('d',0, 'a',0, 'alpha',0, 'offset',0);
            %Set the joint limits
         

            self.model = SerialLink(link, 'name', self.name);
        end
    end
end