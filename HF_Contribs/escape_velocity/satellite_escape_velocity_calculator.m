%modelling of satellite escape velocity calculator in Matlab/Octave

clc;
clear all;
close all;

G = 6.673*(10^(-11));
M = input('Enter mass of the planet(in Kg): ');
R = input('Enter Radius of the planet(in m): ');
VE = sqrt((2*G*M)/R);
printf('escape velocity of satellite is : %f m/s \n',VE);

