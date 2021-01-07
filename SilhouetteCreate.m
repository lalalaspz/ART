function [silhouettes]=SilhouetteCreate(images,fn)

T=max(max(max(images)))*0.1;
for i=1:fn
     silhouettes(:,:,i) = images(:,:,i)>T; 
     bw(:,:,i)=silhouettes(:,:,i);  
     bw_open=bwareaopen(bw(:,:,i),30); 
     bw_fill=imfill(bw_open,'holes'); 
     contour(:,:,i)=bwperim(bw_fill); 
     silhouettes(:,:,i)=bw_fill;
end