 close all;


example_folder = '../examples/Flower Color Change Small';
ext = '.jpg';

A_path = fullfile(example_folder,strcat('A',ext));
Ap_path = fullfile(example_folder,strcat('Ap',ext));
B_path = fullfile(example_folder,strcat('B',ext));
Bp_path = fullfile(example_folder,strcat('Bp',ext));

image_b = create_image_analogy(A_path,Ap_path,B_path);
figure;

imshow(image_b);
