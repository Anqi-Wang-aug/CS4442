%% 3a: display the 200th image
images = load('faces.dat');
image200 = reshape(images(200, :),[64,64]);
figure
imshow(mat2gray(image200));

%% plot the original the 100th image (for myself to see the effect of the modification later)
image100 = reshape(images(100, :), [64, 64]);
figure
imshow(mat2gray(image100));

%% 3b part1: remove mean of the images
means = mean(images);
[r,c] = size(images);
for i=1:1:r
    for j = 1:1:c
        images(i,j) = images(i,j)-means(j); 
    end
end

%% 3b part2: graph the 100th image
image100 = reshape(images(100, :), [64, 64]);
figure
imshow(mat2gray(image100));

%% 3c: pca
[coeff,score, latent, ~, explained]  = pca(images);
explained(1)
plot(latent)

%% 3f: display five largest eigenvector
for i = 1:1:5
    imagen = reshape(coeff(:,i),[64,64]);
    figure
    imshow(mat2gray(imagen));
end

%% 3g: reconstruct 100th image into 1st, 100th, 200th, and 399th principle component
image10010 = zeros(4096, 1);
clc
for i = 1:1:10
    image10010 = image10010+coeff(:,i)*coeff(:,i)'*images(100,:)';
end
image10010 = reshape(image10010, [64,64]);
figure
imshow(mat2gray(image10010));
image100100 = zeros(4096, 1);
clc
for i = 1:1:100
    image100100 = image100100+coeff(:,i)*coeff(:,i)'*images(100,:)';
end
image100100 = reshape(image100100, [64,64]);
figure
imshow(mat2gray(image100100));
image100200 = zeros(4096,1);
clc
for i = 1:1:200
   image100200 = image100200+coeff(:,i)*coeff(:,i)'*images(100, :)';
end
image100200 = reshape(image100200, [64,64]);
figure
imshow(mat2gray(image100200));
image100399 = zeros(4096,1);
clc
for i = 1:1:399
    image100399 = image100399+coeff(:,i)*coeff(:,i)'*images(100, :)';
end
image100399 = reshape(image100399, [64,64]);
figure
imshow(mat2gray(image100399));

%% below are plots to compare the difference between graphs
figure
plot(image100)
figure 
plot(image10010)
figure
plot(image100100)
figure
plot(image100200)
figure 
plot(image100399)