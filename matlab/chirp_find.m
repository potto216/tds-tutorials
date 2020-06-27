clear

%https://howthingsfly.si.edu/ask-an-explainer/how-does-speed-sound-air-vary-temperature

%T_F=66
%target_distance_feet=16+11/12;
%target_distance_feet=8+10/12;
%filename='test_rcv_array_mic_glass_door_8_feet.wav'

T_F=61
target_distance_feet=10
filename='sunrise-array-mic-usb-speaker-10ft.wav'

% target_distance_feet=20
% filename='sunrise-array-mic-usb-speaker-20ft.wav'
% 
% target_distance_feet=30
% filename='sunrise-array-mic-usb-speaker-30ft.wav'



T_C=(T_F-32)*5/9;
speed_of_sound_in_air_m_per_sec=331+0.6*T_C
meter_to_feet=3.281;
target_distance_m=target_distance_feet/meter_to_feet;
round_trip_distance_m=2*target_distance_m;



[x,x_fs]=audioread('test.wav');
%[y,y_fs]=audioread('test_rcv.wav'); %18 feet from laundry metal doors
%[y,y_fs]=audioread('test_rcv_array_mic_glass_door.wav'); %16 feet 11 inches to door
[y,y_fs]=audioread(filename); %8 feet 10 inches to door

[corr_x_x, lag_x]=xcorr(x,x);

[corr_ch1, lag_ch1]=xcorr(x,y(:,1));

[corr_ch2, lag_ch2]=xcorr(x,y(:,2));

%d_ch1=speed_of_sound_in_air_m_per_sec./([0:(numel(corr_ch1)-1)]/x_fs);
t_ch1=[0:(numel(corr_ch1)-1)]/x_fs;
d_ch1=speed_of_sound_in_air_m_per_sec*t_ch1;

%%
figure;
plot(lag_x,20*log10(abs(corr_x_x)))

%%
figure;
plot(d_ch1,20*log10(abs(corr_ch1)))
title(['CH1 round trip = ' num2str(round_trip_distance_m,4) 'm for ' filename])
xlabel('distance (m)')
ylabel('Correlation (dB)')
%%
figure;
plot(d_ch1,20*log10(abs(corr_ch2)))
title(['CH2 round trip = ' num2str(round_trip_distance_m,4) 'm for ' filename])
xlabel('distance (m)')
ylabel('Correlation (dB)')




%(cd(1).Position(1)-cd(2).Position(1))*3.281