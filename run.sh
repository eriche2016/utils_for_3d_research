#!/bin/bash

#################################################
# voxelized modelnet40 data for my own 
#################################################
if [ 1 -eq 1 ]; then 
    echo 'runing script which will convert .off files (polygon meshes) to voxelized model'
    matlab -nodisplay -nosplash -r 'convert_mesh2voxel_folder;exit;' 
fi 

