function [voxels] = CreateVisualHull(silhouettes, voxels, params)

object_points3D = [voxels(:,1)'; voxels(:,2)'; voxels(:,3)'; ones(1, length(voxels))];
voxels(:, 4) = zeros(size(voxels(:, 4)));

for i = 1:size(params,3)  
    M = params(:,:,i);
    % projecting voxels centers to image    
    points2D = M*object_points3D;
    object_points_cam = ceil(points2D./[points2D(3,:); points2D(3,:); points2D(3,:)]);
    object_points_cam(object_points_cam <= 0) = 1;

    % insure that projected voxels are inside image
    img_size = size(silhouettes);
    ind1 = find(object_points_cam(2,:)>img_size(1));
    object_points_cam(:,ind1) = 1;
    ind1 = find(object_points_cam(1,:)>img_size(2));
    object_points_cam(:,ind1) = 1;

    % increase counter of each voxel for object pixel
    ind = int32(sub2ind(img_size(1:2), object_points_cam(2,:)',object_points_cam(1,:)'));    
    cur_silhouette = silhouettes(:,:,i);
    img_val = cur_silhouette(uint32(ind));
    voxels([1:numel(img_val)], 4) = voxels([1:numel(img_val)], 4) + img_val(:);
    end
end



