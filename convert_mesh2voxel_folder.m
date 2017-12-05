addpath('./io')
addpath('./polygon2voxel/') 

% obj2vox_batch('./modelnet40_objs.txt', 30, 0, '../data/modelnet40_vol') 
off2vox_batch('./modelnet40_offs.txt', 30, 0, '../data/modelnet40_vol') 
