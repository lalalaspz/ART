close all;
clear;
clc;
%% Load and process the video, create the silhouettes
filename='SampleVideo.avi';
[images,fn]=VideoProcess(filename);
silhouettes=SilhouetteCreate(images,fn);
for i=1:fn;
    figure(1)
    imagesc(silhouettes(:,:,i));pause(0.01);
end

%% Load camera matrix, calibrated by Camera Calibrator Toolbox
t=[0; 4.10e-3; 51.40e-3];
K=[19339.4071176550,0,0;
    0,19243.0650033993,0;
    0,0,1];
theta=linspace(0,2*pi,fn);
R1=zeros(3,3,fn);
vSet=viewSet;
for i=1:fn;
    R1(:,:,i)=[1 0 0; 0 cos(theta(i)) sin(theta(i)); 0 -sin(theta(i)) cos(theta(i))]; 
    M(:,:,i)=K*([R1(:,:,i) t]);
    pos(:,i)=([R1(:,:,i) t])*[0;0;0;1]; 
    orientation=R1(:,:,i);
    location=-R1(:,:,i).'*t;
    vSet=addView(vSet, i, 'Orientation', orientation, 'Location', location);
end
camPoses=poses(vSet);

%% create voxel grid
voxel_size=[0.5 0.5 0.5]*1e-4;
xlim=[0 52]*1e-4;
ylim=[-15 15]*1e-4;
zlim=[-15 15]*1e-4;  
[voxels, voxel3Dx, voxel3Dy, voxel3Dz, voxels_number]=InitializeVoxels(xlim, ylim, zlim, voxel_size);

%% project voxel to silhouette
[voxels_voted]=CreateVisualHull(silhouettes, voxels, M);
voxels_voted1=(reshape(voxels_voted(:,4), size(voxel3Dx)));
maxv=max(voxels_voted(:));

%% apply marching cube algorithm and display the result
maxv=max(voxels_voted(:,4));
iso_value=maxv-round(((maxv)/100)*5)-1.5;
[voxel3D]=ConvertVoxelList2Voxel3D(voxels_number, voxel_size, voxels_voted);
[faces, verts, colors]=isosurface(voxel3Dx, voxel3Dy, voxel3Dz, voxel3D, iso_value, voxel3Dz);
figure(2);
p=patch('vertices', verts, 'faces', faces,'FaceColor',[0.5,0.5,0.5],'FaceAlpha',.3)
axis equal;
axis tight;
axis off;
view(-28,-36);