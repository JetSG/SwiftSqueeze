classdef guiAndControllerStop < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure        matlab.ui.Figure
        StartButton     matlab.ui.control.Button
        StopButton      matlab.ui.control.Button
    end

    % Callbacks for StartButton and StopButton
    methods (Access = private)
        % Code to run when the StartButton is pressed
        function startButtonPushed(app, event)
            % Place your e-stop activation logic here
            % e.g., set eStopPressed to true
            eStopPressed = true;
            resPressed = false;
            disp('Emergency Stop Activated');
        end

        % Code to run when the StopButton is pressed
        function stopButtonPushed(app, event)
            % Place your e-stop deactivation logic here
            % e.g., set eStopPressed to false and resPressed to true
            eStopPressed = false;
            resPressed = true;
            disp('System Resumed');
        end
    end

    % App Designer initialization
    methods (Access = public)
        function createComponents(app)
            % Create UIFigure and components
            % ... (Auto-generated code for the GUI components)
            
            % Set button callbacks
            app.StartButton.ButtonPushedFcn = createCallbackFcn(app, @startButtonPushed, true);
            app.StopButton.ButtonPushedFcn = createCallbackFcn(app, @stopButtonPushed, true);
        end

        % Create UIFigure
        function createFigure(app)
            app.UIFigure = uifigure;
            % ... (Auto-generated code for figure properties)
        end

        % Construct the app
        function app = MyJoystickApp
            % Create UIFigure and components
            createFigure(app);

            % Initialize e-stop and resume states
            eStopPressed = false;
            resPressed = false;
        end

        % Close the app and release joystick resources when done
        function delete(app)
            % Release joystick resources
            delete(joy);
            % Delete UIFigure
            delete(app.UIFigure);
        end
    end

    methods (Access = public)
        % Code that executes when the app is created
        function startupFcn(app)
            % Initialize the joystick input
            joy = vrjoystick(1); % Assumes the first joystick device
            % Add your joystick control logic here
            while true
                [axes, buttons, povs] = read(joy);
                eStopB = buttons(2); % Adjust this index based on your joystick
                resB = buttons(1); % Adjust this index based on your joystick
                % Check the joystick buttons and update e-stop and resume states
                % (similar to the code provided in your previous message)
                if eStopPressed
                    % E-stop is active
                    if eStopB && resB
                        eStopPressed = false;
                        resPressed = true;
                        disp("System Resumed");
                    end
                else
                    % E-stop is not active
                    if eStopB
                        eStopPressed = true;
                        resPressed = false;
                        disp("Emergency Stop Activated");
                    end
                end

                % ...
                pause(0.1); % Adjust polling rate as needed
            end
        end
    end

    % The main function to run the app
    methods (Access = public)
        function run(app)
            startupFcn(app); % Start the joystick control
        end
    end

    methods (Access = public, Static, Hidden)
        function app = runApplication
            app = guiAndControllerStop;
            app.run;
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = guiAndControllerStop
            createComponents(app);
            % Wait for the app to close before running the code to release the joystick
            waitfor(app.UIFigure);
        end
    end
end
