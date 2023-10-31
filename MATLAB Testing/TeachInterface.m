classdef TeachInterface < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure           matlab.ui.Figure
        XEditField_4       matlab.ui.control.NumericEditField
        XEditField_4Label  matlab.ui.control.Label
        X_dobot            matlab.ui.control.NumericEditField
        X_dobot_field      matlab.ui.control.Label
        JUICEButton        matlab.ui.control.Button
        RESUMEButton       matlab.ui.control.Button
        STOPButton         matlab.ui.control.Button
        ZEditField_2       matlab.ui.control.NumericEditField
        ZEditField_2Label  matlab.ui.control.Label
        YEditField_2       matlab.ui.control.NumericEditField
        YEditField_2Label  matlab.ui.control.Label
        KinovaButton       matlab.ui.control.Button
        Z_dobot            matlab.ui.control.NumericEditField
        Z_dobot_field      matlab.ui.control.Label
        Y_dobot            matlab.ui.control.NumericEditField
        Y_dobot_field      matlab.ui.control.Label
        DobotButton        matlab.ui.control.Button
    end

    
    properties (Access = public)
        Property % Description
        robot = DobotMagician;
  
    end
    
    methods (Access = private)
        
        function results = func(app)
            
        end
    end

    methods (Access = private)

        % function animateDobot(app, x, y, z, steps, Dobot)
        %     lemonPosikcon = Dobot.model.ikcon(transl(position));
        % 
        %     jointTrajectory = jtraj(Dobot.model.getpos(), lemonPosikcon, steps);
        % 
        %     for j = 1:steps
        %         q = jointTrajectory(j, :); % Get joint configuration for the current step
        %         Dobot.model.animate(q); % Animate the robot
        %         drawnow();
        %     end
        % end 
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: DobotButton
        function DobotButtonPushed(app, event)
            dobot_x = app.X_dobot.Value;
            dobot_y = app.Y_dobot.Value;
            dobot_z = app.Z_dobot.Value;
            

            q00 = app.robot.model.getpos;
            newq1 = app.robot.model.ikcon(transl(dobot_x,dobot_y,dobot_z));
          
            qtraj1 = jtraj(q00, newq1, 25);
          
            for i = 1:size(qtraj1, 1)
            app.robot.model.animate(qtraj1(i,:));
            drawnow();
            pause(0);
            end
            disp(app.robot.model.fkine(newq1))
          
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'MATLAB App';

            % Create DobotButton
            app.DobotButton = uibutton(app.UIFigure, 'push');
            app.DobotButton.ButtonPushedFcn = createCallbackFcn(app, @DobotButtonPushed, true);
            app.DobotButton.BackgroundColor = [0.302 0.7451 0.9333];
            app.DobotButton.Position = [203 355 100 23];
            app.DobotButton.Text = 'Dobot';

            % Create Y_dobot_field
            app.Y_dobot_field = uilabel(app.UIFigure);
            app.Y_dobot_field.HorizontalAlignment = 'center';
            app.Y_dobot_field.Position = [146 295 25 22];
            app.Y_dobot_field.Text = 'Y';

            % Create Y_dobot
            app.Y_dobot = uieditfield(app.UIFigure, 'numeric');
            app.Y_dobot.HorizontalAlignment = 'center';
            app.Y_dobot.BackgroundColor = [0.5961 0.8 0.8902];
            app.Y_dobot.Position = [204 295 97 22];

            % Create Z_dobot_field
            app.Z_dobot_field = uilabel(app.UIFigure);
            app.Z_dobot_field.HorizontalAlignment = 'center';
            app.Z_dobot_field.Position = [146 268 25 22];
            app.Z_dobot_field.Text = 'Z';

            % Create Z_dobot
            app.Z_dobot = uieditfield(app.UIFigure, 'numeric');
            app.Z_dobot.HorizontalAlignment = 'center';
            app.Z_dobot.BackgroundColor = [0.5961 0.8 0.8902];
            app.Z_dobot.Position = [204 268 97 22];

            % Create KinovaButton
            app.KinovaButton = uibutton(app.UIFigure, 'push');
            app.KinovaButton.BackgroundColor = [0.302 0.7451 0.9333];
            app.KinovaButton.Position = [384 355 100 23];
            app.KinovaButton.Text = 'Kinova';

            % Create YEditField_2Label
            app.YEditField_2Label = uilabel(app.UIFigure);
            app.YEditField_2Label.HorizontalAlignment = 'center';
            app.YEditField_2Label.Position = [329 295 25 22];
            app.YEditField_2Label.Text = 'Y';

            % Create YEditField_2
            app.YEditField_2 = uieditfield(app.UIFigure, 'numeric');
            app.YEditField_2.HorizontalAlignment = 'center';
            app.YEditField_2.BackgroundColor = [0.5961 0.8 0.8902];
            app.YEditField_2.Position = [387 295 97 22];

            % Create ZEditField_2Label
            app.ZEditField_2Label = uilabel(app.UIFigure);
            app.ZEditField_2Label.HorizontalAlignment = 'center';
            app.ZEditField_2Label.Position = [329 268 25 22];
            app.ZEditField_2Label.Text = 'Z';

            % Create ZEditField_2
            app.ZEditField_2 = uieditfield(app.UIFigure, 'numeric');
            app.ZEditField_2.HorizontalAlignment = 'center';
            app.ZEditField_2.BackgroundColor = [0.5961 0.8 0.8902];
            app.ZEditField_2.Position = [387 268 97 22];

            % Create STOPButton
            app.STOPButton = uibutton(app.UIFigure, 'push');
            app.STOPButton.BackgroundColor = [1 0 0];
            app.STOPButton.FontColor = [1 1 1];
            app.STOPButton.Position = [156 134 100 100];
            app.STOPButton.Text = 'STOP';

            % Create RESUMEButton
            app.RESUMEButton = uibutton(app.UIFigure, 'push');
            app.RESUMEButton.BackgroundColor = [0 1 0];
            app.RESUMEButton.Position = [271 134 100 100];
            app.RESUMEButton.Text = 'RESUME';

            % Create JUICEButton
            app.JUICEButton = uibutton(app.UIFigure, 'push');
            app.JUICEButton.BackgroundColor = [1 1 0.0667];
            app.JUICEButton.Position = [384 134 100 100];
            app.JUICEButton.Text = 'JUICE';

            % Create X_dobot_field
            app.X_dobot_field = uilabel(app.UIFigure);
            app.X_dobot_field.HorizontalAlignment = 'center';
            app.X_dobot_field.Position = [146 322 25 22];
            app.X_dobot_field.Text = 'X';

            % Create X_dobot
            app.X_dobot = uieditfield(app.UIFigure, 'numeric');
            app.X_dobot.HorizontalAlignment = 'center';
            app.X_dobot.BackgroundColor = [0.5961 0.8 0.8902];
            app.X_dobot.Position = [204 322 97 22];

            % Create XEditField_4Label
            app.XEditField_4Label = uilabel(app.UIFigure);
            app.XEditField_4Label.HorizontalAlignment = 'center';
            app.XEditField_4Label.Position = [329 322 25 22];
            app.XEditField_4Label.Text = 'X';

            % Create XEditField_4
            app.XEditField_4 = uieditfield(app.UIFigure, 'numeric');
            app.XEditField_4.HorizontalAlignment = 'center';
            app.XEditField_4.BackgroundColor = [0.5961 0.8 0.8902];
            app.XEditField_4.Position = [387 322 97 22];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = TeachInterface

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end