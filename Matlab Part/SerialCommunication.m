% Matlab + Arduino Serial Port communication
% Autor: Mario Pérez Esteso - Geeky Theory

close all;
clc;
y=zeros(1,1000); %Vector donde se guardarán los datos

%Declaration of Serial Port
delete(instrfind({'Port'},{'COM7'}));
serial_port=serial('COM7');
serial_port.BaudRate=115200;
warning('off','MATLAB:serial:fscanf:unsuccessfulRead');

%Open Serial Port
fopen(serial_port); 

%Declaro un contador del número de muestras ya tomadas
number_samples= 100;
counter_samples=1;

%Creo una ventana para la gráfica
figure('Name','Serial communication: Matlab + Arduino')
title('SERIAL COMMUNICATION MATLAB+ARDUINO');
xlabel('Wert der Probe');
ylabel('Voltage (V)');
grid on;
hold on;

%Bucle while para que tome y dibuje las muestras que queremos
while counter_samples<=number_samples
        ylim([0 5.1]); 
        xlim([counter_samples-20 counter_samples+5]);
        valor_potenciometro=fscanf(serial_port,'%d')';
        y(counter_samples)=(valor_potenciometro(1))*5/1024;
        plot(counter_samples,y(counter_samples),'X-r');        
        drawnow
        counter_samples=counter_samples+1;
end

%Cierro la conexión con el puerto serial y elimino las variables
fclose(serial_port); 
delete(serial_port);
clear all;

