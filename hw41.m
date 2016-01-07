clear variables
close all
clc

%read the image
originalImg = imread('pic/Lenna.jpg');

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

temp = originalImg;
for j =  1 + offset : (height - offset)
    for i = 1 + offset : (width - offset)
        leftTopCoordinateX = i - offset;
        leftTopCoordinateY = j - offset;
        f = [];
        for y = leftTopCoordinateY : leftTopCoordinateY + (2 * offset)
            for x = leftTopCoordinateX : leftTopCoordinateX + (2 * offset)
                f(end + 1) = openingImg(y, x);
            end
        end
        
        intensity = dilation(f, b, radius);
        temp(j, i) = intensity;
        
    end
end

closingImg = originalImg;
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
        
        intensity = erosion(f, b, radius);
        closingImg(j, i) = intensity;
        
    end
end
figure, imshow(closingImg);