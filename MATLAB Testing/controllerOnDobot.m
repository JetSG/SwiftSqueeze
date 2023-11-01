%% Robotics
% Lab 11 - Question 1 solution

%% setup joystick
id = 1; % Note: may need to be changed if multiple joysticks present
joy = vrjoystick(id);
caps(joy) % display joystick information


%% Set up robot
robot = DobotMagician();                   % Create copy called 'robot'


%% Start "real-time" simulation
qn=[0,pi/4,pi/4,0,0];
q = qn;                 % Set initial robot configuration 'q'

HF = figure(1);         % Initialise figure to display robot

robot.model.delay = 0.001;    % Set smaller delay when animating

duration = 300;  % Set duration of the simulation (seconds)
dt = 0.1;      % Set time step for simulation (seconds)

n = 0;  % Initialise step count to zero 
tic;    % recording simulation start time
while( toc < duration)
    
    n=n+1; % increment step count

    % read joystick
    [axes, buttons, povs] = read(joy);
       
    % -------------------------------------------------------------
    % YOUR CODE GOES HERE
    % 1 - turn joystick input into an end-effector velocity command
    Kv = 0.2; % linear velocity gain
    Kw = 1.0; % angular velocity gain
    
    vx = Kv*axes(2);
    vy = Kv*axes(1);
    vz = Kv*(buttons(5)-buttons(7));
    
    wx = Kw*axes(4);
    wy = Kw*axes(3);
    wz = Kw*(buttons(6)-buttons(8));
    
    dx = [vx;vy;vz;wx;wy;wz]; % combined velocity vector
    
    % 2 - use J inverse to calculate joint velocity
    J = robot.model.jacob0(q);
    dq = pinv(J)*dx;
    
    % 3 - apply joint velocity to step robot joint angles 
    q = q + dq'*dt;
      
    % -------------------------------------------------------------
    
    % Update plot
    robot.model.animate(q);  
    
    % wait until loop time elapsed
    if (toc > dt*n)
        warning('Loop %i took too much time - consider increating dt',n);
    end
    while (toc < dt*n); % wait until loop time (dt) has elapsed 
    end
end