//---------------Q1----------------//
s = poly(0, 's');
G = syslin('c', 10/(s*((s/5)+1)*((s/20)+1)));
nyquist(G, 0.1, 500);
g_margin(G)
p_margin(G)
Lag_Comp = G*(s+3)/(s+1);
G_LagComp = syslin('c', Lag_Comp);
scf();
nyquist(G_LagComp, 0.1, 500);
g_margin(G_LagComp)
p_margin(G_LagComp)
Lead_Comp = G*(s+1)/(s+3);
G_LeadComp = syslin('c', Lead_Comp);
scf();
nyquist(G_LeadComp, 0.1, 500);
g_margin(G_LeadComp)
p_margin(G_LeadComp)
//------------------Q2-----------//
s = poly(0, 's');
G = syslin('c', ((s^2+(100*%pi)^2)/(s^2 + 2*s + (100*%pi)^2)));
scf();
bode(G, 1, 100);
K = 1:20:100;
tfs = [];
labels = [];
for i=1:size(K, 2)
    k = K(i);
    G = syslin('c', ((s^2+(100*%pi)^2)/(s^2 + 2*k*s + (100*%pi)^2)));
    tfs = [tfs; G];
    str = sprintf("$K = %d$", k);
    labels = [labels; str];
end
scf();
gainplot(tfs, 10, 1000, labels);
//------------Q3-----------//
s = poly(0, 's');
C = syslin('c', 100/(s+30));
[Phase_m, fm] = p_margin(C)
g_margin(C)
Phase_m
fm
scf();
show_margins(C, 'nyquist');
T = Phase_m*(%pi/180)/(2*%pi*fm);
CG = syslin('c', C*(1-0.5*s*T+(1/9)*(s*T)^2 - (1/72)*(s*T)^3 + (1/1008)*(s*T)^4 - (1/30240)*(s*T)^5)/(1+0.5*s*T + (1/9)*(s*T)^2 + (1/72)*(s*T)^3 + (1/1008)*(s*T)^4 + (1/30240)*(s*T)^5));
scf();
show_margins(CG, 'nyquist');
g_margin(CG)
p_margin(CG)
scf();
bode(C);
scf();
bode(CG);
//--------------Q4--------------//
s = poly(0, 's');
G = syslin('c', 1/(s^3 + 3*s^2 + 2*s));
Kr = kpure(G);
Gain_m = 20 * log(Kr) / log(10);
Gain_m
scf();
evans(G, 10);
sgrid;
scf();
show_margins(G, 'bode');
scf();
bode_asymp(G);
scf();
nyquist(G, 0.1, 100);
//-------------Q5------------//
s = poly(0, 's');
G = syslin('c', (10*s+2000)/(s^3 + 202*s^2 + 490*s + 18001));
show_margins(G, 'bode');
K = 9*18001 / 2000;
G1 = syslin('c', K*G);
K
[Gain_m, fg] = g_margin(G1);
[Phase_m, fp] = p_margin(G1);
Gain_m
fg
Phase_m
fp
G2 = syslin('c', G1*(s+1));
[Gain_m2, fg2] = g_margin(G2);
[Phase_m2, fp2] = p_margin(G2);
Gain_m2
fg2
Phase_m2
fp2
G2_Closed = G2/.syslin('c', 1, 1);
[zero, pole, gain] = tf2zp(G2_Closed);
pole
scf();
show_margins(G2);