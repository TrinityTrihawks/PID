%% PID_Tuning_Calculator.m
        % 2/20/17
        % Stephen Norlien
        % get csv file from roboRIO, get necessary information from file,
        % calculate new inputs, and display new inputs
 clc; clear;
 %% Getting CSV file
 dat=csvread('log_2017-05-02_173221.csv', 2,0); % use the file name for the csv
 time = (1:length(dat(:,1)))*1/50;
 x=nextpow2(length(time));
 theta=dat(:,1);
 Theta = fft(theta);
 L = length(theta);
 FS = 50;
 freq = FS*linspace(0,1/2,L);
 plot(time,-theta);
 xlabel('time (s)');
 ylabel('oscelation');
 
 %% Finding Gain and Period
 period=  freq(find(max(Theta) == Theta));
 frequency=1/period(1);
 Pu=(period);
 Ku=(input('what is the ultimate gain?'));
 %% Calculating 
 % First calculate the Kcnew w/2, Second Kc and Ti w/2.2 and 1.2
 % respectively, Finally Kc w/1.7 Ti w/2 Td w/8
 Kcnew=Ku/1.7;  % 2; 2.2; 1.7;
 Tintnew=Pu/2; % 1.2; 2;
 Tdernew=Pu/8;

%  Knew=(K/2)*(1+sqrt(1-(4*Td/Ti)));
%  Tinew=(Ti/2)*(1+sqrt(1-(4*Td/Ti)));
%  Tdnew=(Td/2)*(1+sqrt(1-(4*Td/Ti)));
%  
 
 Kp=Kcnew;
 Ki=Kcnew/Tintnew;
 Kd=Tdernew*Kcnew;
 %% Display
%  disp('first set of variables are as follows');
%  disp(Kcnew, Tintnew, Tdernew);
%  disp('second set of variables are as follows');
%  disp(Knew, Tinew, Tdnew);
 disp('we input the following variables');
 disp([num2str(Kp), ',' num2str(Ki), ',' , num2str(Kd)]);