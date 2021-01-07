MATLAB code supporting the paper: Acoustofluidic Rotational Tweezing Enables High-Speed Contactless Morphological Phenotyping of Zebrafish Larvae, Nature Communications, 2021.

Description:
[3D reconstruction code]
1. The code is based on marching cube algorithm.
2. Please put all the files under the same folder.
3. Code will generate a sample 3D model of zebrafish with the input video. 
4. main.m should be the program to be run, other files are functions supporting the main program.
5. The input camera matrix is calibrated for specific camera. Videos captured by other cameras will need to input the recalibrated matrix.

MATLAB functions required by the scripts.
1. VideoProcess.m Input the 8-bit video and generate the inverted image stack.
2. SilhouetteCreate.m Process the image stack, generate the silhouettes.
3. InitializeVoxels.m, CreateVisuall.m, CovertVoxelList2Voxel3D.m are tailored and used based on Maxim (2021). Visual Hull Matlab (https://www.mathworks.com/matlabcentral/fileexchange/45989-visual-hull-matlab), MATLAB Central File Exchange. Retrieved January 6, 2021.
--------------------------------------------------------------------------
Test condition:
Matlab R2016b
Memory: 64GB
--------------------------------------------------------------------------
main file : Main.m