classdef KinovaLink6v2 < RobotBaseClass

    properties(Access = public)
        plyFileNameStem = 'Kinovav2';
    end

    methods
        function self = KinovaLink6v2(baseTr)
            self.CreateModel()
            if nargin < 1
                baseTr = eye(4);
            end
            self.model.base = self.model.base.T * baseTr * trotx(pi/2) * troty(pi/2);
            self.PlotAndColourRobot();
        end

        function CreateModel(self)
            %Create the Kinova Link 6 model
            link(1) = Link('d',137.50, 'a',0, 'alpha',pi/2, 'offset',0);
            link(2) = Link('d',0, 'a',485, 'alpha',0, 'offset',0);
            link(3) = Link('d',152.16, 'a',0, 'alpha',-pi/2, 'offset',0);
            link(4) = Link('d',222.75, 'a',0, 'alpha',0, 'offset',0);
            link(5) = Link('d',0, 'a',87.08, 'alpha',pi/2, 'offset',0);
            link(6) = Link('d',0, 'a',92, 'alpha',0, 'offset',0);

            %Set the joint limits
         

            self.model = SerialLink(link, 'name', self.name);
        end
    end
end