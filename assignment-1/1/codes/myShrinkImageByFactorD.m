function output = myShrinkImageByFactorD(d)

input = imread('../data/circles_concentric.png');
output = input(1:d:end, 1:d:end);
imshow(output)

end