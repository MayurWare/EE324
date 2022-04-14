//--------------Q1---------------//
s = poly(0, 's');
T = [1, 2, 8;
     4, 5, 6;
     7, 8, 9];
A = [5, 9, 3;
     10, 2, 5;
     8, 2, 4];
B = [5; 9; 1];
C = [2, 6, 10];
D = 1;
I = eye(3, 3);
G = syslin('c', A, B, C, D);
G_Tf = ss2tf(G);
A_New = pinv(T)*A* T;
B_New = pinv(T)*B;
C_New = C*T;
GT = syslin('c', A_New, B_New, C_New, D);
G_New_Tf = ss2tf(GT);
eig_val = spec(A);
[z, p, k] = ss2zp(G);
p
G_Proper = syslin('c', (s^2+5*s+7)/(s^2+9*s+1));
X = tf2ss(G_Proper);
X
G_S_Proper = syslin('c', (s+3)/(s^2+4*s+9));
Y = tf2ss(G_S_Proper);
Y
//---------------Q2--------------//
s = poly(0, 's');
G = syslin('c', (s+3)/(s^2+5*s+4));
M = tf2des(G);
M
G1 = syslin('c', (s+1)/(s^2+5*s+4));
M1 = tf2des(G1);
M1
//-------------Q3----------------//
A = [1,0,0;
     0,2,0;
     0,0,3];
B = [1;4;6];
C = [2,3,5];
D = 5;
[z1,p1,k1] = ss2tf(A,B,C,D)
A2 = [1,0,0;0,2,0;0,0,3];
B2 = [1;0;6];
C2 = [2,3,5];
D2 = 5;
[z2,p2,k2] = ss2tf(A2,B2,C2,D2)
A3 = [1,0,0;
      0,2,0;
      0,0,3];
B3 = [1;4;6];
C3 = [2,3,0];
D3 = 5;
[z3,p3,k3] = ss2tf(A3,B3,C3,D3)
//-----------------Q4--------------//
s = poly(0, 's');
A = [9, 6, 0;
     0, 4, 3;
     0, 0, 2];
B = [2; 3; 7];
C = [4, 3, 9];
D = 4;
eig_val = spec(A);
eig_val
G = syslin('c', A, B, C, D);
G = ss2tf(G);
[z, p, k] = tf2zp(G);
p
A_New = [4, 6, 0;
         0, 4, 3;
         0, 0, 2];
eig_val = spec(A_New);
eig_val
G = syslin('c', A_New, B, C, D);
G = ss2tf(G);
[z, p, k] = tf2zp(G);
p