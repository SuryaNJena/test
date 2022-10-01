%modelling of radar system and finding object distance in matlab/Octave
clc;
clear all;
close all;
n1=input('Enter the time sample ranges: ');
x=input('enter the sequence: ');
d=input('enter the required amount to delay: ');%its a software simulation not a hardware based project
velo=input('enter velocity of transmission of sequence in terms of mach(1 mach = 343 m/s): ');
w=randn(1,length(n1));%gaussian random noise
y=x+w;%reciving sequence with delay
n2=n1+d;%time sample range of recived signal
r=xcorr(y,x);%cross correlation
q=xcorr(x,y);
n1=-fliplr(n1);
nl=min(n1)+min(n2);%Starting index of cross correlation sequence
nh=max(n1)+max(n2);%Ending index of cross correlation sequence
np=nl:1:nh;
subplot(2,1,1);
stem(np,r,'linewidth',2);
xlabel('time in seconds');
ylabel('amplitude in Volts');
title('correlation output');
subplot(2,1,2);
stem(r,'linewidth',2);
xlabel('time in seconds');
ylabel('amplitude in Volts');
title('just correlation output');
displacement=(velo*343*d)/2;
if(displacement<=1000)%radar can detect body within 1000 meters radius
printf('distance of body from ATC is %f meters\n',displacement);
else
printf('system couldnot detect body\n');
endif
