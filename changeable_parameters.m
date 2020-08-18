%changeable_parameters
% Parameters from the paper
L1 = 0.278;
L2 = 0.300;
l1 = 0.150;
l2 = 0.148;
m1 = 0.300;
m2 = 0.075;
J1 = 2.48*10^(-4);
J2 = 3.86*10^(-3);
b1 =1.00*10^(-4); 
b2 =2.80*10^(-4); 
L = 0.005; 
R = 7.80;
Km = 0.090;
J1_hat=J1+(m1*(l1^2));
J2_hat=J2+(m2*(l2^2));
J0_hat=J1_hat+(m2*(L1^2));
G=9.8;
%constants in equations

A1=-J2_hat*b1;
A2=m2*L1*l2*b2;
A3=-(J2_hat)^2;
A4=-(0.5)*J2_hat*m2*L1*l2;
A5=J2_hat*m2*L1*l2;
A6=J2_hat;
A7=-m2*L1*l2;
A8=0.5*(m2^2)*(l2^2)*L1;
B1=m2*L1*l2*b1;
B2=-b2*J0_hat;
B3=-b2*J2_hat;
B4=m2*L1*l2*J2_hat;
B5=0.5*J0_hat*J2_hat;
B6=0.5*(J2_hat^2);
B7=-0.5*(m2^2)*(L1^2)*(l2^2);
B8=-m2*L1*l2;
B9=J0_hat;
B10=J2_hat;
B11=-m2*l2*J0_hat;
B12=-m2*l2*J2_hat;
C1=-Km/L;
C2=-R/L;
C3=-1/L;
C4=Km;
D1=J0_hat*J2_hat;
D2=J2_hat^2;
D3=-(m2^2)*(L1^2)*(l2^2);
tau_1_activation=1;
E0=0;
K_swingup=10;


%LQR
co_den=D1+D3;
LIN1=  (G*(m2^2)*(l2^2)*L1)/(co_den);
LIN2=   A1/co_den;
LIN3=  -A1/co_den;
LIN4=  (G*m2*l2*J0_hat)/co_den;
LIN5=  -B1/co_den;
LIN6=  B2/co_den;
LIN7=  A6/co_den;
LIN8=  -A7/co_den;
LIN9=  -B8/co_den;
LIN10= -B9/co_den;


A=[0 0 1 0;0 0 0 1;0 LIN1 LIN2 LIN3;0 LIN4 LIN5 LIN6];
B=[0 0;0 0 ; LIN7 LIN8;LIN9 LIN10];
B_mod=[0;0;LIN7;LIN9];
C=[1 0 0 0 ; 0 1 0 0 ];
Qaux=[pi 0;0 pi/180];
Q=(C')*(Qaux')*Qaux*C;
Rh=R/Km;
R=B_mod'*Rh*Rh*B_mod;
controller_gain_F= - lqr(A,B_mod,Q,R);
observer_compare=max(abs(eig(A)),abs(eig(A+(B_mod*controller_gain_F))));

obs_poles=observer_compare*-20;

observer_gain_L = -place (A',C',obs_poles)';



