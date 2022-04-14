//----------------Q1-------------------//
//Part a
s = poly(0, 's');
K2 = [0.01, 1, 5, 10, 20, 30];
K1 = 5*K2;
t = 0:0.01:10;
plotcolors = ["scilabred4", "scilab blue2", "scilab green4","scilabmagenta4", "black", "royalblue"];
for i=1:size(K2, 2)
    k2 = K2(i);
    k1 = K1(i);
    G = syslin('c', (s+k1)/(s+k2));
    plot2d(t, csim('step', t, G), style=[color(plotcolors(i))]);
end
xlabel("$t$", 'fontsize', 3);
ylabel("Step Response", 'fontsize', 3);
title(["Step Response of G(s) by varying K1 and K2"], "fontsize", 3);
legend(["$K_2 = 0.01$", "$K_2 = 1$", "$K_2 = 5$", "$K_2 = 10$","$K_2 = 20$", "$K_2 = 30$"]);
scf();
// Part b
t = 0:0.01:1;
for i=1:size(K2, 2)
    k2 = K2(i);
    k1 = K1(i);
    G = syslin('c', (s+k1)/(s+k2));
    plot2d(t, csim('impuls', t, G), style=[color(plotcolors(i))]);
end
xlabel("$t$", 'fontsize', 3);
ylabel("Step Response", 'fontsize', 3);
title(["Impulse Response of G(s) by varying K1 and K2"], "fontsize", 3);
legend(["$K_2 = 0.01$", "$K_2 = 1$", "$K_2 = 5$", "$K_2 = 10$","$K_2 = 20$", "$K_2 = 30$"]);
//----------Q2---------------//
//Part a
s = poly(0, 's');
Pole1 = -3.5;
Pole2 = 2*%i;
Pole3 = -2*%i;
Pole4 = 3*%i;
Pole5 = -3*%i;
G = syslin('c', 1/((s-Pole1)*(s-Pole2)*(s-Pole3)*(s-Pole4)*(s-Pole5)));
evans(G, 500);
// Part b
Shift = 6;
G_Shift = syslin('c', 1/((s-Pole1+Shift)*(s-Pole2+Shift)*(s-Pole3+Shift)*(s-Pole4+Shift)*(s-Pole5+Shift)));
evans(G_Shift, 10000);
scf();
bode(G_Shift);
// Part c
Zero = 100;
G_Modified = syslin('c', G_Shift*(s+Zero)^4);
bode(G_Modified);
// Part d
evans(G_Modified, 10000);
//----------------Q3---------------//
s = poly(0, 's');
Zero = 1;
Pole1 = 5;
Pole2 = 10;
Pole3 = 100;
G = syslin('c', (s+Zero)/((s+Pole1)*(s+Pole2)*(s+Pole3)));
bode(G);
title(["Bode plot of G(s)"], 'fontsize', 3);





