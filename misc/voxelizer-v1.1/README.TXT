Required java version: 1.5.0
Prefered matlab version R2007a

  File wf_loadr14.m has been fixed to work with matlab R14, 
  however some it has not been toughly tested and may be (even 
  more) buggy than the wf_load.m, which works with R2007a.

File importAOIJava.m adds the ArtOfIllusion.jar and voxelizer.jar 
jar files from the current work directory. If the jar files are in a different location, modify the path files accordingly.

TESTING:

To test this plugin is working, run the following commands:

  >> obj = wf_load('sphere.obj');
  >> [ vox res ] = voxelize(obj);
  >> plot3D(vox, res);

The produced output should be a voxelized sphere. sphere1.png 
shows how the sphere looks like half way through the plotting 
process. sphere2.png shows how the sphere looks like once the 
plotting has finished.