%solving a quadratic equation and displaying its roots and graphs and 
%mentioning its zeros in Matlab/GNU octave in a 2D plot graph

clc;
clear all;
close all;

x= [-10:0.001:10];

a = input('enter X^2 coefficient: ');
b = input('enter X coefficient: ');
c = input('enter constant: ');
%quadratic polynomial
y=(a*(x.^2))+(b*x)+c;
%disciminanat
d = (b^2)-(4*a*c);
%roots
x1=(-b+sqrt(d))/(2*a);
x2=(-b-sqrt(d))/(2*a);

if(d>0)
{
  printf('\n real and distinct roots\n');
  printf('\n roots are alpha= %f and beta= %f \n ',x1,x2);
  
}
elseif(d==0)
{
  printf('\n real and similar roots\n');
  printf('\n roots are alpha= %f and beta= %f \n ',x1,x2);
 
}
elseif(d<0)
{
  printf('\n complex roots\n');
  printf('\n roots are alpha= %f and beta= %f \n ',x1,x2);
}
endif
 subplot(1,1,1);
  plot(x,y,'linewidth',2);
  xlabel('x axis');
  ylabel('y axis');
  title('graph 2D plot');
  grid on;




