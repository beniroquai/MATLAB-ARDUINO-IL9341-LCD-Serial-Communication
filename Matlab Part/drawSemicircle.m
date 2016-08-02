a = 270;   % rotation angle for 
r = 50;      % radius of circle


width = 320;
height = 240;

x=-width/2:1:width/2;
y=-height/2:1:height/2;


circle = zeros(height, width);

angle = (a/180)*3.141;
for(i=1:size(x,2))
    for(j=1:size(y,2))
        if(((x(i).^2 + y(j).^2) <= r^2) & (y(j)*cos(angle)-x(i)*sin(angle)>=0))
            circle(j, i) = 1;
        end
    end
end

imagesc(circle)
axis image


