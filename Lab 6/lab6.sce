//-------------------Q1----------------//
//a
s = poly(0,'s');
K = 150.478;
G = 1/((s+3)*(s+4)*(s+12));
S = syslin('c', K*G/(1+K*G));
t = 0:0.1:15
plot(t, csim('step', t, S),'g-');
xlabel("t");
ylabel("Step response");
title("Step Response of G(s)");
//b
s = poly(0,'s');
G = syslin('c', 1/((s+3)*(s+4)*(s+12)));
evans(G, 500);
X = -2.3:0.00001:0;
Damping_Ratio = sqrt(1-0.35^2)/0.35;
Y = -Damping_Ratio.*X;
plot(X, Y, 'g-');
evans(G, 500);
title("Controller for Damping Ratio 0.35");
//d
s = poly(0,'s');
K = %eps:0.1:1.01;
t = 0:0.01:10;
errors = [];
for i=1:size(K, 2)
    k = K(i);
    A = k/((s+3)*(s+4)*(s+12));
    G = syslin('c', A);
    T = G/.syslin('c', 1, 1);
    plot(t, csim('step', t, T),'g-');
    steady_error = 1/(1 + k/(3*4*12));
    errors = [errors, steady_error];
end
xlabel("t");
ylabel("Step response");
title("Unity gain negative feedback for KG(s)");
scf();
evans(syslin('c', 1/((s+3)*(s+4)*(s+12))), 25);
scf();
plot(K, errors, 'g-');
xlabel("K");
ylabel("Steady State Error");
title("Unity gain negative feedback for KG(s)");
//e
s = poly(0,'s')
K = 1:50:1000;
t = 0:0.01:10;
errors = [];
time_set = [];
for i=1:size(K, 2)
    k = K(i);
    A = k/((s+3)*(s+4)*(s+12));
    G = syslin('c', A);
    T = G /. syslin('c', 1, 1);
    Sys = csim('step', t, T)
    steady_value = Sys(size(Sys,2));
    //plot(t, csim('step', t, T), 'g-');
    time_s=();
    for i=1:size(Sys, 2)
        if(Sys(i)-(0.98*steady_value)<= 1e-5);
        time_s($+1) = t(i);
        break;
    end
    time_settle = time_s(size(time_s));
    time_set = [time_set, time_settle];
    steady_error = 1 / (1 + k / (3 * 4 * 12));
    errors = [errors, steady_error];
end
xlabel("t");
ylabel("Step response");
title("Unity gain negative feedback for KG(s)");
scf();
evans(syslin('c', 1/((s+3)*(s+4)*(s+12))), 1000);
scf();
plot(K, errors, 'g-');
xlabel("K");
ylabel("Steady State Error");
title("Steady State Error for K as 1 to 1000");
scf();
plot(K, time_set, 'g');
xlabel("K");
ylabel("Settling Time (Ts)");
title("Settling Time (Ts) for K as 1 to 1000");
//-------------------Q2----------------//
//a
s = poly(0, 's');
G1 = 1/((s+3)*(s+4)*(s+12));
G = syslin('c', G1);
Zeta = 0.2;
Slope = sqrt(1-Zeta^2)/Zeta;
X = -2:0.001:0;
Y = -Slope.*X;
Z = 0.01;
P = syslin('c', G1*(s+Z)/s);
plot(X, Y, 'g-', 'LineWidth', 2);
evans(P, 1500);
title("PI controller for G(s) with a Damping Ratio 0.2");
//b
s = poly(0, 's');
G1 = 1/((s+3)*(s+4)*(s+12));
Zeta = 0.2;
Z = 1.91;
P = syslin('c', G1*(s+Z)/s);
Y = -10:1:10;
X = zeros(1,21);
plot(X,Y);
plot(X1, Y1, 'g-', 'LineWidth', 2);
evans(P, 2000);
title(["PI controller for G(s) with a Undamped Frequency 8 rad/s"], 'fontsize', 3); 
scf();
Z = 0.871;
P = syslin('c', G1*(s+Z)/s);
Y = -10:1:10;
X = zeros(1,21);
plot(X,Y);
plot(X2, Y2, 'g-', 'LineWidth', 2);
evans(P, 2000);
title(["PI controller for G(s) with a Undamped Frequency 9 rad/s"], 'fontsize', 3);
//c
Z = [0.001, 0.1, 0.75, 1, 5, 10, 50];
for i=1:size(Z, 2)
    z = Z(i);
    G1 = 1/((s+3)*(s+4)*(s+12));
    P = syslin('c', G1*(s+z)/s);
    scf();
    evans(P, 1000);
    title([sprintf("z = %0.3f", z)], 'fontsize', 3)
end
//-------------------Q3----------------//
s = poly(0,'s');
G = syslin('c', 1/(s^2+5*s+6));
f = [0.1, 0.5, 1, 5, 10];
t = 0:0.1:20;
Half_length = int(length(t)/2);
Gain = [0,0,0,0,0,0];
Phase_diff = [0,0,0,0,0,0];
for i=1:length(f)
    X = sin(2*%pi*f(i)*t);
    Y = csim(X,t,G);
    Amp_In = (max(X(Half_length:$))-min(X(Half_length:$)))/2;
    Amp_Out = (max(Y(Half_length:$))-min(Y(Half_length:$)))/2;
    gain(i) = Amp_Out/Amp_In;
    Temp1 = find(X(length(t)-400:length(t))==max(X(length(t)-400:length(t))));
    Temp2 = find(Y(length(t)-400:length(t))==max(Y(length(t)-400:length(t))));
    T1 = t(Temp1(1)+length(t)-400-1);
    T2 = t(Temp2(1)+length(t)-400-1);
    Phase_diff(i) = (T2-T1)*2*%pi*f(i);
    scf();
    clf();
    plot(t,Y,'g-');
    xlabel("t");
    title("Output Response");
end
Num_gain = [0,0,0,0,0,0];
Num_phase = [0,0,0,0,0,0];
for j=1:length(f)
    jw = %i*2*%pi*f(j);
    Gain1 = 1/((jw)^2+5*(jw)+6);
    Num_gain(j) = abs(Gain1);
    Num_phase(j) = atan(imag(Gain1)/real(Gain1));
end






