clc;
clear all;

load('mesh_hks.mat');


mesh15_hks=zeros(100,101);
mesh54_hks=zeros(100,101);

fprintf('Program paused. Press enter to apply Hungarian Algorithm to the shapes\n');
pause;


for i=1:100
    mesh15_hks(i,:)=mesh015_hks(1+(i-1)*125,:);
    mesh54_hks(i,:)=mesh054_hks(1+(i-1)*125,:);
end
costmat= Euclidean_distance(mesh15_hks,mesh54_hks);

[C]=Hungarian(costmat);

fprintf('Program paused. Press enter to find the nearest point for the original shape\n');
pause;

infile='mesh015.off';

fid=fopen(infile);
fgetl(fid);
nos=fscanf(fid, '%d %d %d',[3 1]);
nopts=nos(1);
notrg=nos(2);

coord=fscanf(fid, '%g %g %g',[3 nopts]);
coord=coord';

triang=fscanf(fid, '%d %d %d %d',[4 notrg]);
triang=triang';
triang=triang(:,2:4)+1;

fclose(fid);

% Edist= Euclidean_distance(coord,coord);
% 
% G=sparse(nopts,nopts);
% 
% for i=1:notrg
%     p1=triang(i,1);
%     p2=triang(i,2);
%     p3=triang(i,3);
%     G(p1,p2)= Edist(p1,p2);
%     G(p2,p1)= Edist(p2,p1);
%     G(p1,p3)= Edist(p1,p3);
%     G(p3,p1)= Edist(p3,p1);
%     G(p2,p3)= Edist(p2,p3);
%     G(p3,p2)= Edist(p3,p2);
% end
% Gdist=graphallshortestpaths(G);
% 
% 
%  f_vec=zeros(1,size(Gdist,1));
%  listPoints=1:125:12500;
%  
%     for i=1:1:nopts
%         disMin=inf;
%         indexPointMin=0;
%         for j=1:1:size(listPoints,2)
%             if Gdist(i,listPoints(j))<disMin
%                 indexPointMin=j;
%                 disMin=Gdist(i,listPoints(j));
%             end
%         end
%         f_vec(1,i)=listPoints(indexPointMin);
%     end
load('f_vec.mat');
  fprintf('Program paused. Press enter to write the vtk file for the original shape\n');
pause;

    
outfile='mesh015.vtk';
ofid=fopen(outfile,'w');
fprintf(ofid, '# vtk DataFile Version 3.0\n');
fprintf(ofid, 'vtk output\n');
fprintf(ofid,'ASCII\n');
fprintf(ofid,'DATASET POLYDATA\n');
fprintf(ofid,'POINTS %d float\n',nopts);
fprintf(ofid,'%g %g %g\n',coord');
fprintf(ofid,'POLYGONS %d %d\n',notrg,4*notrg);
fprintf(ofid,'3 %d %d %d\n',triang'-1);
fprintf(ofid,'\n');
fprintf(ofid,'POINT_DATA %d\n',nopts);
fprintf(ofid,'SCALARS distance_from float 1\n');
fprintf(ofid,'LOOKUP_TABLE default\n');
fprintf(ofid,'%g\n',f_vec);
fclose(ofid);

fprintf('Program paused. Press enter to find the nearest point for the Test shape\n');
pause;

infile='mesh054.off';

fid=fopen(infile);
fgetl(fid);
nos=fscanf(fid, '%d %d %d',[3 1]);
nopts=nos(1);
notrg=nos(2);

coord=fscanf(fid, '%g %g %g',[3 nopts]);
coord=coord';

triang=fscanf(fid, '%d %d %d %d',[4 notrg]);
triang=triang';
triang=triang(:,2:4)+1;

fclose(fid);
% 
% Edist= Euclidean_distance(coord,coord);
% 
% G=sparse(nopts,nopts);
% 
% for i=1:notrg
%     p1=triang(i,1);
%     p2=triang(i,2);
%     p3=triang(i,3);
%     G(p1,p2)= Edist(p1,p2);
%     G(p2,p1)= Edist(p2,p1);
%     G(p1,p3)= Edist(p1,p3);
%     G(p3,p1)= Edist(p3,p1);
%     G(p2,p3)= Edist(p2,p3);
%     G(p3,p2)= Edist(p3,p2);
% end
% Gdist=graphallshortestpaths(G);
% 
%  f_vec=zeros(1,size(Gdist,1));
%  listPoints=1:125:12500;
%  
%  for i=1:1:100
%      listPoint(1,i)=listPoints(1,C(1,i));
%  end
%  
%     for i=1:1:nopts
%         disMin=inf;
%         indexPointMin=0;
%         for j=1:1:size(listPoint,2)
%             if Gdist(i,listPoint(j))<disMin
%                 indexPointMin=j;
%                 disMin=Gdist(i,listPoint(j));
%             end
%         end
%         f_vec(1,i)=listPoint(indexPointMin);
%     end
    
fprintf('Program paused. Press enter to write the vtk file for the test shape\n');
pause;

outfile='mesh054.vtk';
ofid=fopen(outfile,'w');
fprintf(ofid, '# vtk DataFile Version 3.0\n');
fprintf(ofid, 'vtk output\n');
fprintf(ofid,'ASCII\n');
fprintf(ofid,'DATASET POLYDATA\n');
fprintf(ofid,'POINTS %d float\n',nopts);
fprintf(ofid,'%g %g %g\n',coord');
fprintf(ofid,'POLYGONS %d %d\n',notrg,4*notrg);
fprintf(ofid,'3 %d %d %d\n',triang'-1);
fprintf(ofid,'\n');
fprintf(ofid,'POINT_DATA %d\n',nopts);
fprintf(ofid,'SCALARS distance_from float 1\n');
fprintf(ofid,'LOOKUP_TABLE default\n');
fprintf(ofid,'%g\n',f_vec);
fclose(ofid);