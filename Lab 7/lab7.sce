//--------------Q1--------------------//
s = poly(0, 's');
G = 1/(s*(s^2+4*s+8));
//Part a
K = 0:0.01:100;
K_required = 0;
Gain_margins = [];
Phase_margins = [];
for i=1:size(K, 2)
    k = K(i);
    c_eqn = 1+k*G; //Defined characteristic equation
    C_Eqn = syslin('c', c_eqn);
    Gain_m = g_margin(C_Eqn);
    Phase_m = p_margin(C_Eqn);
    Gain_margins = [Gain_margins, Gain_m];
    Phase_margins = [Phase_margins, Phase_m];
    if abs(Gain_m) <= 1e-5 && abs(Phase_m) <= 1e-5 then
        K_required = k;
    end
end
plot(K, Gain_margins, 'g-', 'LineWidth', 2);
plot(K(2:size(K, 2)), Phase_margins, 'b-', 'LineWidth', 2);
xlabel("K", 'fontsize', 3);
ylabel("Gain, Phase Margin", 'fontsize', 3);
title(["Variation of Gain and Phase Margin with K varied from 0 to 100"], "fontsize", 3);
legend(["Gain Margin in dB", "Phase Margin in degrees"]);
K_required
G_new = 1+K_required*G;
show_margins(G_new);
//Part b
if abs(Gain_m − Phase_m) <= 1e-5 then
    K_required = k;
end
// Part c
s = poly(0, 's');
G = 1/(s*(s^2+4*s+8));
c_eqn = 1+K_required*G);
C_Eqn = syslin('c', c_eqn);
[Zeros, Poles, Gain] = tf2zp(C_Eqn);
Zeros
//------------------------Q2--------------------------//
s = poly(0, 's');
Ratio = 20;
t = 0:0.01:30;
// Part a
K = 4.476;
Slope = %pi/log(10);
G = syslin('c', 1/(s^2+3*s+2));
plot(t, csim('step', t, K*G/.syslin('c',1,1)), 'g-');
xgrid(0);
xlabel("t");
ylabel("Step Response");
title("Step Response of G(s)");
X = -3:0.01:0;
Y = -Slope*X;
scf();
plot(X, Y, 'g-', 'LineWidth', 2);
evans(G, 500);
xlabel("Real axis");
ylabel("Imaginary axis");
title("Evans root locus");
// Part b
K = 4.476;
SSE = 1/(1+K*0.5)
Pole = 0.0001;
Zero = Ratio*Pole;
G_LagComp = (s+Zero)/((s+Pole)*(s^2+3*s+2));
scf();
plot(t, csim('step', t, syslin('c',K*G_LagComp/(1+K*G_LagComp))), 'g-');
xgrid(0);
xlabel("t");
ylabel("Step Response");
title("Step Response of G(s) with Lag Compensation");
SSE_LagComp = 1/(1+(K*20*0.5));
// Part c
s = poly(0, 's');
Ratio = 20;
t = 0:0.01:20;
Poles = [0.0001, 0.01, 1, 5, 10];
slope = %pi/log(10);
X = -5:0.01:5;
Y = -slope*X;
for i=1:size(Poles, 2)
    pole = Poles(i);
    Zero = pole*Ratio;
    G_LagComp = syslin('c', (s+Zero)/((s+pole)*(s^2+3*s+2)));
    scf();
    plot(t, csim('step', t, K*G_LagComp/(1+K*G_LagComp)), 'g-');
    //evans(G_LagComp, 500);
    //plot(X, Y, 'g-', 'LineWidth', 2);
    title(sprintf("Step Response of KG_LagComp(s) with Pole at −%.4f and Zero at −%.4f", pole, Zero));
    xlabel("t");
    ylabel("Step Response");
end
//----------------Q3----------------//
s = poly(0, 's');
K = 4.476
G = syslin('c', K/(s^2+3*s+2));
t_settle = 2.3357;
Slope = %pi/log(10);
X = -4:0.001:2;
Y = -Slope*X;
evans(G, 500);
plot(X, Y, 'g-', 'LineWidth', 2);
t_settle_new = t_settle/2;
new_Real = -4/t_settle_new;
new_Im = -Slope*new_Real;
plot(new_Real, new_Im, 'go', 'LineWidth', 2);
//Assuming the zero of the lead compensator is at −5
Z_c = 5;
[z, p, g] = tf2zp(G);
if z ~= [] then
    Zeroes = zeros(size(z, 1), 2);
end
if p ~= [] then
    Poles = zeros(size(p, 1), 2);
end
for i=1:size(p, 1)
    Pi = p(i);
    Pi = [real(Pi), imag(Pi)];
    Poles(i, :) = Pi;
end
for i=1:size(z, 1)
    Zi = z(i);
    Zi = [real(Zi), imag(Zi)];
    Zeroes(i, :) = Zi;
end
Angles = 0;
for i=1:size(Poles, 1)
    A = [new_Real, new_Im]-Poles(i, :);
    Angles = Angles - atan(A(2), A(1));
end
Angles = Angles + atan(new_Im, Z_c + new_Real);
Angle_new_Pole = Angles - %pi + 2*%pi;
P_c = (new_Im/tan(Angle_new_Pole)) - new_Real;
G_LeadComp = syslin('c', ((s+Z_c)*K)/((s^2+3*s+2)*(s + P_c)));
// Part b
Angles = 0;
for i=1:size(Poles, 1)
    A = [new_Real, new_Im] - Poles(i, :);
    Angles = Angles - atan(A(2), A(1));
end
Angle_new_Zero = -Angles + %pi;
Z_c = (new_Im/tan(Angle_new_Zero)) - new_Real;
G_pd = syslin('c', K*(s+Z_c)/(s^2+3*s+2));

















