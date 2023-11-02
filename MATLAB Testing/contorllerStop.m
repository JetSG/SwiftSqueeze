% Initialize the joystick input
joy = vrjoystick(1); % Assumes the first joystick device

% Initialize variables to keep track of button presses
eStopPressed = false;
resPressed = false;

% Loop to continuously check for button presses
while true
    % Get the current joystick input
    [axes, buttons, povs] = read(joy);

    % Check the e-stop button press
    eStopB = buttons(2); % Adjust this index based on your joystick
    resB = buttons(1); % Adjust this index based on your joystick

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
    pause(0.1);
end
