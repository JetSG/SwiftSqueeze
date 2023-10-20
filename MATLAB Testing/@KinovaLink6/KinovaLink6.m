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
            self.model.base = self.model.base.T * baseTr * trotx(pi/2) * troty(pi/2);
            self.PlotAndColourRobot();
        end

        function CreateModel(self)
            %Create the Kinova Link 6 model
            link(x) = Link([]);

            %Set the joint limits
            link(x).qlim = [];

            self.model = SerialLink(link, 'name', self.name);
        end
    end
end