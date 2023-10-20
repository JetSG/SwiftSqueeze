

tableFilePath = 'table.ply';
figure;
workspace = [-2 1.2 -2.2 2.2 -0.4 1.5]; %Doesnt work>

%       TABLE
[f, v, data] = plyread(tableFilePath, 'tri');
vertexColors = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;
tableMesh = patch('Vertices', v, 'Faces', f, 'FaceVertexCData', vertexColors, 'FaceColor', 'interp', 'EdgeColor', 'none');
hold on;
tableMesh.Vertices = tableMesh.Vertices + [0,0,-0.39];



LinearDobot(); %DH

view(3);
