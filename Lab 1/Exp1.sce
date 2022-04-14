\\EE324 | Experiment 1 | Mayur Ware | 19D070070
\\----------------Q1------------------ \\
s= poly(0,'s');
G1 = syslin('c',10/(s^2+2*s+10));
G2 = syslin('c',5/(s+5));
\\------------------------------------------
\\ a) Cascade System
TF1 = syslin('c', G1*G2);
disp(TF1, "Transfer Function TF1(s) is");
\\------------------------------------------                                                        
\\ b) Parallel System
TF2 = syslin('c', G1+G2);
disp(TF2, "Transfer Function TF2(s) is");
\\-----------------------------------------
\\ c) Feedback System
TF3 = syslin('c', G1/(1+G1*G2));
disp(TF3, "Transfer Function TF3(s) is");
\\-----------------------------------------
\\ d) Plot
t = 0:0.05:10
plot2d(t, csim('step', t, G1), style=[color("blue")]);
\\to show the grids
xgrid(0); 
\\ Title of Graph
title(["Step Response of G1(s)"]);
\\ X-axis label
xlabel("t");
\\ Y-axis label
ylabel("y(t)");
\\-------------------Q2--------------------- \\
\\ a) Cascade System
[zeros_a, poles_a, gain_a] = tf2zp(TF1);
disp(zeros_a,"Zeros of TF1(s)");
disp(poles_a,"Poles of TF1(s)");
plzr(TF1);
\\to show the grids
xgrid(0); 
\\ Title of Graph
title("Poles and Zeros of TF1(s)");
\\X-axis label
xlabel("Real Axis");
\\Y-axis label
ylabel("Imaginary Axis");
\\--------------------------------------------
\\ b) Parallel System
[zeros_b, poles_b, gain_b] = tf2zp(TF2);
disp(zeros_b,"Zeros of TF2(s)");
disp(poles_b,"Poles of TF2(s)");
plzr(TF2);
\\to show the grids
xgrid(0); 
\\ Title of Graph
title("Poles and Zeros of TF2(s)");
\\X-axis label
xlabel("Real Axis");
\\Y-axis label
ylabel("Imaginary Axis");
\\---------------------------------------------
\\ c) Feedback System
[zeros_c, poles_c, gain_c] = tf2zp(TF3);
disp(zeros_c,"Zeros of TF3(s)");
disp(poles_c,"Poles of TF3(s)");
plzr(TF3);
\\to show the grids
xgrid(0); 
\\ Title of Graph
title("Poles and Zeros of TF3(s)");
\\X-axis label
xlabel("Real Axis");
\\Y-axis label
ylabel("Imaginary Axis");
\\-------------------Q3----------------- \\
\\ Matrix Calculations Practice
s = poly(0,'s');
\\ 3*3 Matrix A
A = [ 3*s^2+5*s+4, 7*s, 47; 34, 1/s, 29*s; 2*s^3+5, 5, 3/s];
\\ 3*3 Matrix B
B = [4*s^3, 4/(3*s+5), 23; 41*s+6, 3*s^2+5*s-14, 57; s^2-6, 3*s, 78];
\\ Addition
disp(A+B, "A+B is :");
\\ Multiplication
disp(A*B, "A*B is :");
\\ Inverse
disp(inv(B), "Determinant of B is :");
\\ Determinant
disp(det(B), "Determinant of B is :");
\\------------------Q4------------------- \\
s = poly(0,'s');
\\ Impedance Matrix
Z=[2+2*s+1/(1+s), −1/(1+s), −(s+1); −1/(1+s), 3+s+1/(1+s), −2; −(s+1), −2, 6+s+1/(1+s)];
\\ Voltage Matrix
V = [0; 0; 1];
\\ I = V*Z^-1
inv(Z)*V;








