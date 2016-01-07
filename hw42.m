clear variables
close all
clc

%read the image
originalImg = imread('pic/tree.jpg');

%get height and width
[height, width, color] = size(originalImg);

figure, imshow(originalImg);

radius = 5;
temp = originalImg;
b = zeros(radius, radius, 'uint8');

offset = floor(radius / 2);

for j =  1 + offset : (height - offset)
    for i = 1 + offset : (width - offset)
        leftTopCoordinateX = i - offset;
        leftTopCoordinateY = j - offset;
        f = [];
        for y = leftTopCoordinateY : leftTopCoordinateY + (2 * offset)
            for x = leftTopCoordinateX : leftTopCoordinateX + (2 * offset)
                f(end + 1) = originalImg(y, x);
            end
        end
        
        intensity = erosion(f, b, radius);
        temp(j, i) = intensity;
        
    end
end

openingImg = originalImg;
for j =  1 + offset : (height - offset)
    for i = 1 + offset : (width - offset)
        leftTopCoordinateX = i - offset;
        leftTopCoordinateY = j - offset;
        f = [];
        for y = leftTopCoordinateY : leftTopCoordinateY + (2 * offset)
            for x = leftTopCoordinateX : leftTopCoordinateX + (2 * offset)
                f(end + 1) = temp(y, x);
            end
        end
        
        intensity = dilation(f, b, radius);
        openingImg(j, i) = intensity;
        
    end
end

result = zeros(height, width, 'uint8');
for y = 1 : height
    for x = 1 : width
        originalIntensity = originalImg(y, x);
        openingIntensity = openingImg(y, x);
        intensity = originalIntensity - openingIntensity;
        result(y, x) = intensity;
    end
end

figure, imshow(result);