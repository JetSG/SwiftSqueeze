classdef GUI < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                   matlab.ui.Figure
        MysterybuttonButton        matlab.ui.control.Button
        JointnumberEditField       matlab.ui.control.NumericEditField
        JointnumberEditFieldLabel  matlab.ui.control.Label
        Animate2Button             matlab.ui.control.Button
        JointangleEditField        matlab.ui.control.NumericEditField
        JointangleEditFieldLabel   matlab.ui.control.Label
        AnimateButton              matlab.ui.control.Button
        ZEditField                 matlab.ui.control.NumericEditField
        ZEditFieldLabel            matlab.ui.control.Label
        YEditField                 matlab.ui.control.NumericEditField
        YEditFieldLabel            matlab.ui.control.Label
        XEditField                 matlab.ui.control.NumericEditField
        XEditFieldLabel            matlab.ui.control.Label
    end

    
    properties (Access = private)
        robot = DobotMagician; % Description
        
        zpos = 0;
        ypos = 0;
        xpos = 0;
        jointno = 0;
        jointangle = 0;
        check = 0;
        
        
        
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Value changed function: ZEditField
        function ZEditFieldValueChanged(app, event)
            app.zpos = app.ZEditField.Value;
            
        end

        % Value changed function: YEditField
        function YEditFieldValueChanged(app, event)
            app.ypos = app.YEditField.Value;
            
        end

        % Value changed function: XEditField
        function XEditFieldValueChanged(app, event)
            app.xpos = app.XEditField.Value;
            
        end

        % Button pushed function: AnimateButton
        function AnimateButtonPushed(app, event)
                q0 = app.robot.model.getpos;
                newq = app.robot.model.ikcon(transl(app.xpos,app.ypos,app.zpos));

                qtraj = jtraj(q0, newq, 25);

                for i = 1:size(qtraj, 1)
                app.robot.model.animate(qtraj(i,:));
                drawnow();
                pause(0);
                end
                disp("All joint angles")
                disp(newq)
                disp("Actual endeffector position")
                disp(app.robot.model.fkine(newq))
        end

        % Value changed function: JointangleEditField
        function JointangleEditFieldValueChanged(app, event)
            app.jointangle = app.JointangleEditField.Value;
            
        end

        % Button pushed function: Animate2Button
        function Animate2ButtonPushed(app, event)
         
% Get the current joint angles
q0 = app.robot.model.getpos;

% Set the new angle for the first joint
new_angle = app.jointangle;
q0(app.jointno) = new_angle;

% Define the full joint configuration for the final pose
% Assuming you want to keep the other joints the same
newq = q0; % Copy the initial joint configuration
newq(app.jointno) = new_angle; % Update the first joint to the desired angle

% Interpolate a trajectory for all joints
qtraj = jtraj(q0, newq, 25);

for i = 1:size(qtraj, 1)
    % Animate the robot with the interpolated joint angles
    app.robot.model.animate(qtraj(i,:));
    drawnow();
    pause(0.1); % You can adjust the pause duration for animation speed
end

                
        end

        % Value changed function: JointnumberEditField
        function JointnumberEditFieldValueChanged(app, event)
            app.jointno = app.JointnumberEditField.Value;
            
        end

        % Button pushed function: MysterybuttonButton
        function MysterybuttonButtonPushed(app, event)
            %% Robotics
% Lab 11 - Question 4 skeleton code

%% setup joystick

id = 1; % Note: may need to be changed if multiple joysticks present
joy = vrjoystick(id);
caps(joy) % display joystick information


%% Set up robot
 clf;                   % Load Puma560
r2 = DobotMagician;                   % Create copy called 'robot'
r2.model.tool = transl(0.01,0,0);   % Define tool frame on end-effector


%% Start "real-time" simulation
q = zeros(1,5);                % Set initial robot configuration 'q'

HF = figure(1);         % Initialise figure to display robot
r2.model.animate(q);          % Plot robot in initial configuration
r2.model.delay = 0.001;    % Set smaller delay when animating
set(HF,'Position',[0.1 0.1 0.8 0.8]);

duration = 300;  % Set duration of the simulation (seconds)
dt = 0.15;      % Set time step for simulation (seconds)

n = 0;  % Initialise step count to zero 
tic;    % recording simulation start time
while( toc < duration)
    
    n=n+1; % increment step count

    % read joystick
    [axes, buttons, povs] = read(joy);
       
    % -------------------------------------------------------------
    % YOUR CODE GOES HERE
    % 1 - turn joystick input into an end-effector force measurement  
    fx = axes(1);
    fy = 0;
    fz = 0;
    
    tx = 0;
    ty = axes(3);
    tz = 0;
    
    f = [fx;fy;fz;tx;ty;tz]; % combined force-torque vector (wrench)
    
    % 2 - use simple admittance scheme to convert force measurement into
    % velocity command
    Ka = diag([0.3 0.3 0.3 0.5 0.5 0.5]); % admittance gain matrix  
    dx = Ka*f; % convert wrench into end-effector velocity command
    
    % 2 - use DLS J inverse to calculate joint velocity
    J = r2.model.jacob0(q);
    
    lambda = 0.1;
    Jinv_dls = inv((J'*J)+lambda^2*eye(5))*J';
    dq = Jinv_dls*dx;
    
    % 3 - apply joint velocity to step robot joint angles
    q = q + dq'*dt;
    % -------------------------------------------------------------
    
    % Update plot
    r2.model.animate(q);  
    
    % wait until loop time elapsed
    if (toc > dt*n)
        warning('Loop %i took too much time - consider increating dt',n);
    end
    while (toc < dt*n); % wait until loop time (dt) has elapsed 
    end
end
      


        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 381 360];
            app.UIFigure.Name = 'MATLAB App';

            % Create XEditFieldLabel
            app.XEditFieldLabel = uilabel(app.UIFigure);
            app.XEditFieldLabel.HorizontalAlignment = 'right';
            app.XEditFieldLabel.Position = [100 292 25 22];
            app.XEditFieldLabel.Text = 'X';

            % Create XEditField
            app.XEditField = uieditfield(app.UIFigure, 'numeric');
            app.XEditField.ValueChangedFcn = createCallbackFcn(app, @XEditFieldValueChanged, true);
            app.XEditField.Position = [140 292 100 22];

            % Create YEditFieldLabel
            app.YEditFieldLabel = uilabel(app.UIFigure);
            app.YEditFieldLabel.HorizontalAlignment = 'right';
            app.YEditFieldLabel.Position = [100 254 25 22];
            app.YEditFieldLabel.Text = 'Y';

            % Create YEditField
            app.YEditField = uieditfield(app.UIFigure, 'numeric');
            app.YEditField.ValueChangedFcn = createCallbackFcn(app, @YEditFieldValueChanged, true);
            app.YEditField.Position = [140 254 100 22];

            % Create ZEditFieldLabel
            app.ZEditFieldLabel = uilabel(app.UIFigure);
            app.ZEditFieldLabel.HorizontalAlignment = 'right';
            app.ZEditFieldLabel.Position = [100 218 25 22];
            app.ZEditFieldLabel.Text = 'Z';

            % Create ZEditField
            app.ZEditField = uieditfield(app.UIFigure, 'numeric');
            app.ZEditField.ValueChangedFcn = createCallbackFcn(app, @ZEditFieldValueChanged, true);
            app.ZEditField.Position = [140 218 100 22];

            % Create AnimateButton
            app.AnimateButton = uibutton(app.UIFigure, 'push');
            app.AnimateButton.ButtonPushedFcn = createCallbackFcn(app, @AnimateButtonPushed, true);
            app.AnimateButton.Position = [140 178 100 23];
            app.AnimateButton.Text = 'Animate';

            % Create JointangleEditFieldLabel
            app.JointangleEditFieldLabel = uilabel(app.UIFigure);
            app.JointangleEditFieldLabel.HorizontalAlignment = 'right';
            app.JointangleEditFieldLabel.Position = [62 69 63 22];
            app.JointangleEditFieldLabel.Text = 'Joint angle';

            % Create JointangleEditField
            app.JointangleEditField = uieditfield(app.UIFigure, 'numeric');
            app.JointangleEditField.Limits = [-360 360];
            app.JointangleEditField.ValueChangedFcn = createCallbackFcn(app, @JointangleEditFieldValueChanged, true);
            app.JointangleEditField.Position = [140 69 100 22];

            % Create Animate2Button
            app.Animate2Button = uibutton(app.UIFigure, 'push');
            app.Animate2Button.ButtonPushedFcn = createCallbackFcn(app, @Animate2ButtonPushed, true);
            app.Animate2Button.Position = [140 33 100 23];
            app.Animate2Button.Text = 'Animate2';

            % Create JointnumberEditFieldLabel
            app.JointnumberEditFieldLabel = uilabel(app.UIFigure);
            app.JointnumberEditFieldLabel.HorizontalAlignment = 'right';
            app.JointnumberEditFieldLabel.Position = [51 108 74 22];
            app.JointnumberEditFieldLabel.Text = 'Joint number';

            % Create JointnumberEditField
            app.JointnumberEditField = uieditfield(app.UIFigure, 'numeric');
            app.JointnumberEditField.ValueChangedFcn = createCallbackFcn(app, @JointnumberEditFieldValueChanged, true);
            app.JointnumberEditField.Position = [140 108 100 22];

            % Create MysterybuttonButton
            app.MysterybuttonButton = uibutton(app.UIFigure, 'push');
            app.MysterybuttonButton.ButtonPushedFcn = createCallbackFcn(app, @MysterybuttonButtonPushed, true);
            app.MysterybuttonButton.Position = [262 33 100 23];
            app.MysterybuttonButton.Text = 'Mystery button';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = GUI

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