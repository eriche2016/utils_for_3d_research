function offobj = off_loader(filename, theta, axis, stretch)
% Read the off file.
% offobj: a struct contains vertices and faces of 3D mesh models.

offobj = struct();
fid = fopen(filename, 'rb');
OFF_sign = fscanf(fid, '%c', 3);
assert(strcmp(OFF_sign, 'OFF') == 1);

info = fscanf(fid, '%d', 3);
offobj.vertices = reshape(fscanf(fid, '%f', info(1)*3), 3, info(1))';
offobj.faces = reshape(fscanf(fid, '%d', info(2)*4), 4, info(2))';

if ~isempty(find(offobj.faces(:,1) == 4, 1))
    fprintf('nononononono\n');
end

% Center model

bbox1 = min(offobj.vertices);
bbox2 = max(offobj.vertices);
center = (bbox1 + bbox2) / 2;
offobj.vertices = bsxfun(@minus, offobj.vertices, center);

if exist('axis', 'var')
    switch axis
        case 'x',
            offobj.vertices(:,1) = offobj.vertices(:,1) * stretch;
        case 'y',
            offobj.vertices(:,2) = offobj.vertices(:,2) * stretch;
        case 'z',
            offobj.vertices(:,3) = offobj.vertices(:,3) * stretch;
        otherwise,
            error('off_loader axis set wrong');
    end
end


% These vertices to define faces should be offset by one to follow the matlab convention.
offobj.faces = offobj.faces(:,2:end) + 1; 

% make the object upright
% original code 
% R = [1 0 0; 0 cos(-pi/2) -sin(-pi/2); 0 sin(-pi/2) cos(-pi/2)];
% R = [1 0 0; 0 cos(-theta) -sin(-theta); 0 sin(-theta) cos(-theta)];
Rz = [cos(theta) -sin(theta) 0; sin(theta) cos(theta) 0; 0 0 1];
% offobj.vertices = offobj.vertices * Rz;

offobj.vertices = offobj.vertices * Rz' ;

fclose(fid);