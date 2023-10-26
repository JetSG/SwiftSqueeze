
% 
% tableFilePath = 'environment.ply';
figure;
workspace = [-3, 3, 0.1, 2.5, -3, 3]; %Doesnt work>
axis equal;
hold on;

%       TABLE
% [f, v, data] = plyread(tableFilePath, 'tri');
% vertexColors = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;
% tableMesh = patch('Vertices', v, 'Faces', f, 'FaceVertexCData', vertexColors, 'FaceColor', 'interp', 'EdgeColor', 'none');
% hold on;
% tableMesh.Vertices = tableMesh.Vertices + [0,0,-0.39];

PlaceObject('tableV3.ply', [0 0 0])

camlight;



% DobotMagician(); %DH

view(3);
