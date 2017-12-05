function obj2vox_batch(obj_filelist, volume_size, pad_size, output_dir)
% OBJ2VOX_BATCH, convert a list of .obj models to volumes and save them to .mat files
%   obj_filelist: string, path for a txt file each line is 
%       the full path for an OBJ model
%   volume_size: integer, final volume size is volume_size+2*pad_size
%   pad_size: integer
%   output_dir: string, output converted volumes to this folder, 
%       if not exists, we will create it. The name for the .mat files are 
%       .obj names with obj replaced with mat.
%
% Author: Charles R. Qi
% Date: Oct 5, 2016

if nargin < 4
    output_dir = '.';
end

if ~exist(output_dir, 'dir')
    mkdir(output_dir); % '../data/modelnet40_vol'
end


% '../data/modelnet40_vol/airplane/volum_size/[train or text]'

obj_filenames = importdata(obj_filelist);
num_rots = 1; % 1 means donot rotate meshes before voxelization, other wise, rotate  

for k = 1:length(obj_filenames)
    if num_rots == 1  
        theta = 0; 
        obj_filename = obj_filenames{k}; % ../data/modelnet40_raw/ModelNet40/glass_box/test/glass_box_0181.off
        disp(obj_filename);
        instance = obj2vox(obj_filename, volume_size, pad_size, theta);

        % make folder based on obj_filename 
        file_path_array = split(obj_filename,'/'); 
        % if not exists make 
        % ../data/modelnet40_vol/glass_box/test[or train]/volume_size/
        store_subfolder = fullfile(output_dir, file_path_array{1}{5}, file_path_array{1}{6}, num2str(volume_size));
        if ~exist(store_subfolder, 'dir')
            mkdir(store_subfolder); % '../data/modelnet40_vol'
        end
        % disp(store_subfolder)

        [~, filename, ~] = fileparts(obj_filename);
        volume_filename = [filename '.mat'];

        save(fullfile(store_subfolder, volume_filename), 'instance');

    else % rotates before voxelization 
        obj_filename = obj_filenames{k};
        for kk = 1:num_rots
            theta =  2 * pi * (kk-1) / num_rots;
            instance = obj2vox(obj_filename, volume_size, pad_size, theta);
            file_path_array = split(obj_filename,'/'); 
            store_subfolder = fullfile(output_dir, file_path_array{1}{5}, file_path_array{1}{6}, num2str(volume_size));
            if ~exist(store_subfolder, 'dir')
                mkdir(store_subfolder); % '../data/modelnet40_vol'
            end

            [~, filename, ~] = fileparts(obj_filename);
            volume_filename = [filename '_' num2str(kk) '.mat'];
            save(fullfile(store_subfolder, volume_filename), 'instance');
        end 
    end 
end

