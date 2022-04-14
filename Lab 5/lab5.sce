//--------------Q1-------------//
//Part a
s = poly(0, 's');
G1 = 1/(s^3 + 4*s^2 + 5*s);
S1 = syslin('c', G1);
evans(S1, 20);
//Part b
s = poly(0, 's');
G2 = (s+1)/(s^2*(s+3.6));
S2 = syslin('c', G2);
evans(S2, 20);
//Part c
s = poly(0,'s');
G3 = (s+0.4)/(s^2*(s + 3.6));
S3 = syslin('c', G3);
evans(S3, 20);
//Part d
p = -7:1:7;
colors = ["red", "blue", "green", "cyan", "magenta", "brown", "pink", "black", "royalblue","gold", "violet"];
for i=1:size(p, 2)
  P = p(i);
  G4 = (s+P)/(s*(s+1)*(s+2));
  S4 = syslin('c', G4);
  evans(S4, 20, style=[color(colors(i))]);
end
//---------------Q2--------------//
//Part a
s = poly(0, 's');
G1 = (s^3-1)/(s^3+5);
S1 = syslin('c', G1);
evans(S1, 20);
//Part b
s = poly(0,'s');
G2 = 1/(s^5-5);
S2 = syslin('c', G2);
evans(S2, 20);
//Part c
s = poly(0,'s');
G3 = 1/(s-5);
S3 = syslin('c', G3);
evans(S3, 20);
//Part d
s = poly(0,'s')
G4a =  1/(s^4-5*s^2+4);
//Replace s^2 to -s^2
G4b = 1/(s^4+5*s^2+4);
//Substitute s as (s-5)
G4 = 1/((s-5)^4+5*(s-5)^2+4);
S4 = syslin('c',G4);
evans(S4,20);
//---------------Q3----------------//
function [time_rise] = trise(t, S, flag)
   out_step = csim('step', t, S);
   steady_val = mean(out_step(size(out_step, 2)-200:size(out_step, 2)));
   if flag then
     steady_val = 1;
   end
   peak_val = max(out_step);
   time_rise_l = 0;
   time_rise_h = 0;
   for i=1:size(out_step, 2)
     if(out_step(i)-(0.1 * steady_val)>= 1e-4)
        time_rise_l = t(i);
        break;
     end
   end
   for i=1:size(out_step, 2)
     if(out_step(i)-0.9 * steady_val>= 1e-4)
     time_rise_h = t(i);
     break;
     end
   end
   time_rise = time_rise_h - time_rise_l;
endfunction
s = poly(0, 's');
G = 1/(s*(s^2 + 3*s + 5));
K = 0.01:0.01:kpure(G);
t = 0:0.01:20;
candidates = [];
for i=1:size(K, 2)
  k = K(i);
  T = syslin('c', k*G);
  T = T/.syslin('c', 1, 1);
  tr = trise(t, T, %f);
  if i == size(K, 2)
   tr = trise(t, T, %t);
  end
  plot(k, tr, 'gx', 'LineWidth', 0.25);
  if tr == 1.5
   candidates = [candidates, k];
  end
end
xlabel("$K_p$", 'fontsize', 3);
ylabel("Rise Time in seconds", 'fontsize', 3);
title(["Rise time vs ", "$K_p$", "fontsize", 3);
disp(candidates(1));
k_crit = kpure(G);
T = syslin('c', k_crit*G);
T = T/.syslin('c', 1, 1);
trise_min = trise(t, T, %t);
disp(trise_min);
//-----------------Q4-----------------//
s = poly(0, 's');
G = 0.11*(s+0.6)/(6*s^2 + 3.6127*s +0.0572);
S = syslin('c', G);
evans(G, 200);
t = 0:0.01:10;
k = 85.8;
scf();
plot(t, csim('step', t, (k*G)/.syslin('c', 1, 1)));
K = -1:0.01:-0.1;
for i=1:size(K, 2)
   k = K(i);
   A = G*k;
   G = syslin('c', A);
   T = G/.syslin('c', 1, 1);
   [zeros, poles, gain] = tf2zp(T);
   x = real(poles);
   if abs(x(1)) <= 1e-4 || abs(x(2)) <= 1e-4
   disp(k);
   end
end
//---------------Q5-------------------//
s = poly(0, 's');
G1 = 75/((s+1)*(s+2)*(s+25));
S1 = syslin('c', G1);
G2 = 3/((s+1)*(s+2));
S2 = syslin('c', G2);
scf();
evans(S1);
scf();
evans(S2);
K = 0.1:0.1:2;
t = 0:0.01:10;
plotcolors = ["scilabred4", "scilab blue2", "scilab green4", "scilab cyan4","scilabmagenta4", "scilabbrown4", "scilabpink4", "black", "royalblue","gold",
"dodgerblue1", "palevioletred", "hotpink1", "royalblue4", "turquoise4","darkgoldenrod4", "rosybrown2", "indianred2", "tan1", "magenta1"];
scf();
for i=1:size(K, 2)
    k = K(i);
    S3 = syslin('c', k*G1);
    S4 = syslin('c', k*G2);
    T1 = S3/.syslin('c', 1, 1);
    T2 = S4/.syslin('c', 1, 1);
    xset("thickness",2);
    plot2d(t, csim('step', t, T1-T2), style=[color(plotcolors(i))]);  
end
legend(["$K = 0.1$","$K = 0.2$","$K = 0.3$","$K = 0.4$","$K = 0.5$","$K = 0.6$","$K = 0.7$","$K = 0.8$","$K = 0.9$","$K = 1$","$K = 1.1$","$K = 1.2$","$K = 1.3$","$K = 1.4$","$K = 1.5$","$K = 1.6$","$K = 1.7$","$K = 1.8$","$K = 1.9$","$K = 2$"], 'location','best');
title(["Difference in unity gain negative feedback", "fontsize", 3);
xlabel("$t$", 'fontsize', 3);
ylabel("Step response", 'fontsize', 3);















