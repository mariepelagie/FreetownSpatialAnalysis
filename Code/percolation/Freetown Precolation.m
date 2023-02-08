%% Read data set
%SL_lonlat_pop = csvread('popdata.csv'); %data in pple/m2
SL_lonlat_pop = csvread('popdata2.csv'); %data in pple/km2
%% Analyze population Distribution%%%%%%%%%%%%%%%%%
% calc distances from chosen coordinates
sl_lonlat_pop_cell=num2cell(SL_lonlat_pop,2); % convert to cells, easier to iterate on (but memory consuming)
%dists = cellfun(@(r) pos2dist(r(2),r(1),8.4553522,-13.2943229,2),sl_lonlat_pop_cell); % calc dists
dists = cellfun(@(r) pos2dist(r(2),r(1),8.488987,-13.206684,2),sl_lonlat_pop_cell);


%%
%Lat vs Lon Plot for Freetown 
plot(SL_lonlat_pop(:,1),SL_lonlat_pop(:,2),'k.')
xlabel('Latitude')
ylabel('Longitude')

%% plot of Freetown with CBD highlighted in green within 0.3km
% find all distances within 0.3km of 
idx=find(dists(:,1)<=0.3);
filtered_by_dists=[SL_lonlat_pop(idx,:) dists(idx,:)];
size(filtered_by_dists)

% display filtered coordinates (validation)
figure
plot(SL_lonlat_pop(:,1),SL_lonlat_pop(:,2),'k.')
hold on
plot(filtered_by_dists(:,1),filtered_by_dists(:,2),'g.')
%%
% Total population within that distance and its Distribution
Pop = SL_lonlat_pop(:,3)
p=Pop; %fraction of population in each cell
[N,val]=histcounts(p,'Normalization', 'probability');
loglog(val(2:end),N)
title('Distribution of fraction of population per km^{2}')
xlabel('p (fraction of population)')
ylabel('Probility distribution of fraction of population p')

%% Filter by pop density
SL_augmented=[SL_lonlat_pop(:,:) dists(:,1)];
% and keep only those with population density of 0.02 or more
idx2=find(SL_augmented(:,3)>0.02);
filtered_by_pop=SL_augmented(idx2,:);

%%
%%Transform Coordinates in pixels
LON=filtered_by_pop(:,1);
LAT=filtered_by_pop(:,2);
DAT=filtered_by_pop(:,3);
DIST=filtered_by_pop(:,4);
dl=0.001; %(minimun resolution between two points)
%pixlatrow=(LAT-min(LAT))/dl;
%pixloncol=(LON-min(LON))/dl;
R = makerefmat(min(LON),min(LAT),dl,dl); %%matlabfunction
[pixlatrow, pixloncol ] = latlon2pix(R,LAT,LON); %%
figure
plot(pixloncol,pixlatrow,'k.');
title('First Matrix with Pixels')
range=180;%decide matrix size based on resulting pixels



%%
%create matrices
map_pop=zeros(range,range);
map_dist=zeros(range,range);
map_bin=zeros(range,range);
for i=1:size(pixlatrow)
    I=int32(pixlatrow(i));
    J=int32(pixloncol(i));
    if(I<=range && J<=range)
      map_pop(I,J)=DAT(i);
      map_dist(I,J)=DIST(i);
      map_bin(I,J)=1;
    end
end
%%
figure
%%Colored heatmap representing distance from CBD
h=pcolor(log(map_pop(1:105,1:160)))
set(h, 'EdgeColor', 'none');

%shading interp
title('Log of Population Density (or third column)')
%%
figure
%%Colored heatmap representing log of pop density
h=pcolor(map_dist(1:105,1:160))
set(h, 'EdgeColor', 'none');
title('Distance from CBD')
%shading interp

%%
%%Fractal Dimension estimation using box counting
[c]=resize_matrix(map_bin);
figure;
spy(flip(c))
figure
boxcount_alg;


%% Label Cluster and see Labeled Matrix
%%Different colors refer to different labels
[blobnumber,blobsize,blobIsize,nsize,biggestblob,labeled]=CountBlobs(map_bin) %%%here the output of the script

step_three = figure('Name','Step Three'); % Labeled Binary Matrix
imagesc(labeled)
shading interp
colorbar
colormap('jet')
set(gca,'YDir','normal')
ylim([0 130])
%each label corrresponds to a different cluster id
labeled

%We see here the biggestblob only
biggestblob

%%Use Red Blue White to paint: Largest, Occupied and Empty
step_four = figure('Name','Step Four'); % Pick Out Largest Region
plotim = (map_bin)+ 2*biggestblob+2; %three colors 2 (empty), 3 (occupied) and 5 (biggest cluster)
stepfourplot = image(plotim);
colormap('flag')
hh = colorbar();
shading interp
set(hh,'YLim',[0.5,3.5])
set(hh,'YTick',[1,2,3])
set(hh,'YTickLabel',{'Largest','Empty','Occupied'})
set(gca,'YDir','normal')
ylim([0 130])
%array with all cluster sizes
blobIsize

%this gives the size of the largest cluster
max(blobIsize)

%nsize counts how many clusters of each size we have doing the histogram of blobIsize between 1 and max(blobIsize)
%%check help matlab histc
nsize

%%
% Display the size distribution
figure()
hplot2 = plot(blobsize,(nsize/sum(nsize)),'ro');
hold on
tau = 187/91; %theoretical value
limiting_size_dist = blobsize.^(-tau); 
%Add a line as a guide to the eye to compare the 
%the scaling around p_c according to percolation theory
hplot3 = plot(blobsize,limiting_size_dist/sum(limiting_size_dist));
ylim([1e-4,1])
xlim([1,100])
xlabel('Cluster Size, n_{s}')
ylabel('P(n_{s})')
title('Distribution of Cluster Sizes');
set(gca,'YScale','log')
set(gca,'XScale','log')
set(gca,'YDir','normal')


 %% Finding xmax and ymax coordinates and maximum density, ?max 
% %rhomax is largest pop density in selested region
 %rhomax= max(filtered_by_pop(:,3));
% 
% ix = find(filtered_by_pop(:,3) == rhomax);
% %values are coordinates of (xmax, ymax)
% values = filtered_by_pop(ix,1:2);
%%
% plot semilog of pop density vs dist
X=dists;
[n,edges,idx] = histcounts(X);%,my_log_scale);
Xbin=accumarray(idx(:),X,[],@mean);

Ybin=accumarray(idx(:),SL_lonlat_pop(:,3),[],@mean);
figure
semilogy(dists,SL_lonlat_pop(:,3),'b*')
hold on;semilogy(Xbin,Ybin,'ro','MarkerFaceColor','r');




%%
% plot semilog of pop density vs dist
Z=filtered_by_pop(:,4);
%[n,edges,idx] = histcounts(Z);%,my_log_scale);
[n,edges,idx] = histcounts(Z, 'BinWidth',0.5)
Xbin=accumarray(idx(:),Z,[],@mean);

Ybin=accumarray(idx(:),filtered_by_pop(:,3),[],@mean);
figure
semilogy(filtered_by_pop(:,4),filtered_by_pop(:,3),'b*')
hold on;semilogy(Xbin,Ybin,'ro','MarkerFaceColor','r');


%% Freetown - Density Profile in Built up area
figure

bar(Xbin, Ybin);
set(gca, 'YGrid', 'on', 'XGrid', 'off')
title('Freetown - Density Profile in Built up area')
xlabel(' Distance (Km)')
ylabel('Population Density(People/Km^2)')


