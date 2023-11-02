%%  SETUP

figure;
workspace = [-3, 3, -5, 2.5, -3, 3];
q = [0,pi/4,pi/4,0,0];
% axis equal
hold on;

dobot = DobotMagician();
kinova = KinovaLink6();


%Positions
lemonStartPos = [0.005, 0.5, 0.775];
lemonOffset = [0, -0.04, 0.008];
lemonWidth = 0.035;
lemonHeight = 0.102;

cuttingBoardPos = [1.160, 0.184, 0.775+0.034]+ lemonOffset;
juicerPos = [1.051, 0.85577, 0.775+0.036];
binPos = [1.33255, 0.85577, 0.775+0.3];




table = PlaceObject('tableV3.ply', [0 0 0]);
lemon1 = PlaceObject('lemon1.ply', lemonStartPos);
lemon2 = PlaceObject('lemon2.ply', lemonStartPos);
% 




% lemon1 = PlaceObject('lemon1.ply', cuttingBoardPos);
% lemon2 = PlaceObject('lemon2.ply', cuttingBoardPos);

camlight;

%Dobot Translation

dobot.model.base = transl(1.5016, 0.1834, 0.775) * trotz(pi);

dobot.model.animate(dobot.model.getpos());



%KinovaTranslation 

kinova.model.base = transl(0.5434, 0.500, 0.775);

kinova.model.animate(kinova.model.getpos());

view(3);


numSteps = 50;


cutEndPos = [0, 0, 0] + cuttingBoardPos;

cutStartPos = [0, 0, 0.28] + cuttingBoardPos; %will be replaced with lemonPos minus relevant values
%%  MAIN
    animateRobot(kinova, numSteps, lemonStartPos, trotx(pi));
    animateRobot(dobot, numSteps, cutStartPos, 1);
    z=0;
for i = 1:10

    
    animateRobot(kinova, numSteps, cuttingBoardPos, trotx(pi)); %move lemon to cutting board
    animateRobot(kinova, numSteps, [1.16, -0.25, 0.8170], trotx(pi)); %move out of the way

    animateRobot(dobot, numSteps, cutEndPos, 1);%cut
    animateRobot(dobot, numSteps, cutStartPos, 1);%startcutpos

    animateRobot(kinova, numSteps, cuttingBoardPos, trotx(pi));%pickup lemon off cuttingboard

    animateRobot(kinova, numSteps, cuttingBoardPos, trotx(pi));%move to juicer
    
    Juice(kinova, steps, 2*pi);
    Juice(kinova, steps, -2*pi);
    Juice(kinova, steps, 2*pi);
    Juice(kinova, steps, 0);




    % for j = 0:0.1:2*pi %juicing
    %     kinova.model.animate(kinova.model.getpos()+[0, 0, 0, 0, 0, 0.1]);
    %     pause(z)
    %     disp(j);
    % end
    % for j = 2*pi:-0.1:-2*pi %juicing
    %     kinova.model.animate(kinova.model.getpos()+[0, 0, 0, 0, 0, -0.1]);
    %     pause(z)
    % end
    % for j = -2*pi:0.1:0 %juicing
    %     kinova.model.animate(kinova.model.getpos()+[0, 0, 0, 0, 0, 0.1]);
    %     pause(z)
    % end
    %     animateRobot(cuttingBoardPos, numSteps, kinova, trotx(pi));%throw lemon in bin



    animateRobot(kinova, numSteps, lemonStartPos, trotx(pi));% go to start




end 


function animateRobot(robot, steps, position, angle)
    lemonPosikcon = robot.model.ikcon(transl(position)*angle);
    
    jointTrajectory = jtraj(robot.model.getpos(), lemonPosikcon, steps);
    
    for j = 1:steps
        q = jointTrajectory(j, :); % Get joint configuration for the current step
        robot.model.animate(q); % Animate the robot
        drawnow();
    end
end 

function Juice(kinova, steps, spinAngle)
    juiceAim = kinova.model.getpos();

    juiceAim(6) = spinAngle;
        
    jointTrajectory = jtraj(kinova.model.getpos(), juiceAim, steps);
    
    for j = 1:steps
        q = jointTrajectory(j, :); % Get joint configuration for the current step
        kinova.model.animate(q); % Animate the robot
        drawnow();
    end
end 
