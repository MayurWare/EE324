// ----------------------EE324 Lab 4----------------
//-------------------Q1-------------------------//
//a
s = poly(0, 's');
G1 = 1/s^2;
G2 = (50*s)/(s^2+s+100);
G3 = s-2;
G4 = 1;
S1 = syslin('c',G1);
S2 = syslin('c',G2);
S3 = syslin('c',G3, 1);
S4 = syslin('c', G4, 1);
TF = (S1 * S2 * S3)/. S4;
//b
G1 = s;
G2 = 1/s;
S1 = syslin('c', G1, 1);
S2 = S1*S1;
S3 = syslin('c', G2);
S4 = S2+S3;
S5 = S4/.syslin('c', 1, 1);
TF = (S5*syslin('c', G2))/.syslin('c', s, 1);
//c
G1 = (3*s^2)/(1 + s) +2*s;
S1 = syslin('c', G1);
G2 = 1/(s + 2);
S2 = syslin('c', G2);
S3 = S2/.syslin('c', 4, 1);
S4 = S3*S1;
TF = S4/.syslin('c', 1, 1);
//-------------------Q2-------------------------//
//a
s = poly(0, 's');
G = 10/(s*(s+2)*(s+4));
S = syslin('c', G);
K = 7;
TF = K*S/.syslin('c', 1, 1);
//b
K = 0:0.1:100;
for i=1:size(K, 2)
  k = K(i);
  S1 = k*S/.syslin('c', 1, 1);
  [zeros, poles, gain] = tf2zp(S1);
  plot(real(poles), imag(poles), 'gx');
end
xlabel("Real Axis");
ylabel("Imaginary Axis");
title("Locus of Closed Loop Poles of TF(s)");
//c
K_C = -1;
for i=1:size(K, 2)
    k = K(i);
    S2 = k*S/.syslin('c', 1, 1);
    [zeros, poles, gain] = tf2zp(S2);
    Real_Poles = real(poles);
    if Real_Poles(1) > 0 
        K_C = k;
        break;
    end
    if Real_Poles(2) > 0 
        K_C = k;
        break;
    end
    if Real_Poles(3) > 0 
        K_C = k;
        break;
    end
end
//-------------------Q3-------------------------//
//a
s = poly(0, 's');
G1(s) = s^5+3*s^4+5*s^3+4*s^2+s+3;
disp(routh_t(G1(s));
//b
s = poly(0, 's');
G2(s) = s^5+6*s^3+5*s^2+8*s+20;
disp(routh_t(G2(s));
//c
s = poly(0, 's');
G3(s) = s^5-2*s^4+3*s^3-6*s^2+2*s-4;
disp(routh_t(G3(s));
//d
s = poly(0, 's');
G4(s) = s^6+s^5-6*s^4+s^2+s-6;
disp(routh_t(G4(s));



















