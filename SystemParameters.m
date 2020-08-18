clc
clear all
close all 
%system parameters 
%theta2 in equilibrium is equal to 0
theta2_Init = pi +0.1 ;
%tau2 %Disturbance torque
%tau1 %Motor torque
g = 9.8
M1= 0.3 %kg
M2= 0.075 %kg
%Mass Location
l1= 0.15 %m
l2= 0.148 %m
b1 = 10^-4 %Nms damping coefficent
b2 = 2.8*(10^-4) %Nms damping coefficent (free joint)
%Motor Parameters
L = 0.005 %Henry
R = 7.8 %ohm
Km = 0.09 %Nm/A
L1 = 0.278 %m
L2 = 0.3 %m
J1= 2.48*(10^-2) %kg/m^2 inertia tensors (moment of inertia in 3D)
J2= 3.86*(10^-3) %kg/m^2 inertia tensors (moment of inertia in 3D)
%Jm1=[0 0 0;0 J1 0;0 0 J1] %Symmetry about X-axis, then Jxx equals zero
%Jm2=[0 0 0;0 J2 0;0 0 J2] %Symmetry about X-axis, then Jxx equals zero
J1Hat = J1 + M1*((l1)^2)
J2Hat = J2 + M2*((l2)^2)
JNotHat = J1Hat + M2*((L1)^2)
%%
%System matrix elements:
%Denm = (JNotHat*J2Hat - (M2^2)*(L1^2)*(l2^2))
%A31 = 0
%A32 = (g*M2^2*l2*2*L1)/Denm
%A33 =  (-b1*J2Hat)/Denm
%A34 =  (-b2*M2*l2*L1)/Denm
%A41 =  0
%A42=  (g*M2*l2*JNotHat)/Denm
%A43=  (-b1*M2*l2*L1)/Denm
%A44=  (-b2*JNotHat)/Denm
%B31=  J2Hat/Denm
%B32= (M2*L1*l2)/Denm
%B41= (M2*L1*l2)/Denm
%B42= JNotHat/Denm

