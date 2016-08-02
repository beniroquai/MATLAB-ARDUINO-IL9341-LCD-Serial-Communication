% Matlab + Arduino Serial Port communication
% Sending Zernike Polynomials to Arduino

close all;
clear all;
clc;

x_width = 240;
y_width = 320;

x_width = 50;
y_width = 50;

x_offset = 0;
y_offset = 50;

%Declaration of Serial Port
delete(instrfind({'Port'},{'COM7'}));
serial_port=serial('COM7');
serial_port.BaudRate=250000;
warning('off','MATLAB:serial:fscanf:unsuccessfulRead');

%Open Serial Port
fopen(serial_port); 

%Generate Image with pixel-number according to Arduino
x = linspace(-1, 1, x_width);
[X,Y] = meshgrid(x,x);
[theta,r] = cart2pol(X,Y);
idx = r<=1;
z = nan(size(X));
z(idx) = zernfun(5,1,r(idx),theta(idx));
z = padarray(z, [0, (y_width-size(z, 1))/2], z(1,1));
z = imadjust(z)*(2^8-1);
 
figure
imagesc(z), shading interp
axis image, colorbar
title('Zernike function Z_5^1(r,\theta)')
drawnow 

z = uint8(z);
z = (cat(3, z, z, z));
%z = (cat(3, .299*z, .587*z, .114*z));
%z = uint8(z);


%Wait until Arduino is ready for communication
result = 0;
while(result~=-1.0)
    result=fscanf(serial_port,'%d')  
end

pause(1)

%Setup ROI, where the Image should be updated
fprintf(serial_port,'S'); %sends command for x_width (image)
data = sprintf('%c', x_width);
fprintf(serial_port, data); %sends string via serial
 

pause(1); % Arduino needs some time until data is processed!


%Setup Offset, where the Image should be updated
fprintf(serial_port,'O'); %sends command for x_width (image)
data = sprintf('%c%c', y_offset, y_offset);
fprintf(serial_port, data); %sends string via serial
 
pause(1)



%send image data over serial port
fprintf(serial_port,'I'); %sends string via serial
disp('Start')
for j=1:size(z, 2) % rows     
    for i=1:size(z, 1) % cols
        red = z(i, j, 1);
        green = z(i, j, 2);
        blue = z(i, j, 3);
             
        % Convert Pixel from Grayvalue to Binary representation
        red_array = fliplr(de2bi(double(red)));
        red_bin = zeros(1,16);
        red_bin(1, (1+size(red_bin,2)-size(red_array,2)):end)=red_array;
        
        green_array = fliplr(de2bi(double(green)));
        green_bin = zeros(1,8);
        green_bin(1, (1+size(green_bin,2)-size(green_array,2)):end)=green_array;       
        
        blue_array = fliplr(de2bi(double(blue)));
        blue_bin = zeros(1,8);
        blue_bin(1, (1+size(blue_bin,2)-size(blue_array,2)):end)=blue_array;       
        
        % p >>= 3;
        red_bin = circshift(red_bin,3,2);
        % p <<= 6;
        red_bin = circshift(red_bin,-6,2); 
        
        % g >>= 2;
        green_bin = circshift(green_bin,2,2); 
        
        % p |= g;
        red_bin = bitor(red_bin, padarray(green_bin, [0, 8], 'pre'));
        % p <<= 5;
        red_bin = circshift(red_bin,-5,2);
        
        % b >>= 3;        
        blue_bin = circshift(blue_bin,3,2);

        % p |= b;
        data = bitor(red_bin, padarray(blue_bin, [0, 8], 'pre'));
        
        upper_byte = data(1:8);
        lower_byte = data(9:end);

        data_matrix(i, j, 1) = bi2de(upper_byte);
        data_matrix(i, j, 2) = bi2de(lower_byte);
        
        data = sprintf('%c%c', bi2de(upper_byte), bi2de(lower_byte));
        fprintf(serial_port, data); %sends string via serial
        
    end
    %disp(strcat('Row: ', num2str(j) ))
end

% Close connection and reset
% fclose(serial_port); 
% delete(serial_port);

