//---------------------Q1------------------//
//a
s = poly(0, 's');
P = -1:0.01:1;
for i=1:size(P, 2)
      a = P(i);
      [Num, Den] = simp(s + 5 + a, s^2 + 11*s + 30);
      Sys = syslin('c', Num, Den);
      t=0:0.05:10;
      plot(t, csim('step', t, Sys), 'g-');
      xgrid(0);
      xlabel("t");
      ylabel("Step Response");
      title("Step Response variations with a");
end
//b
//i
G = syslin('c', 1/(s^2-s-6));
t=0:0.05:10;
plot(t, csim('step', t, G), 'g-');
xgrid(0);
xlabel("t");
ylabel("Step Response");
title("Step Response of G(s)");
//ii
S = syslin('c', 1/(s + 2));
plot(t, csim('step', t, S), 'g-');
xgrid(0);
xlabel("t", 'fontsize', 3);
ylabel("Step Response");
title("Step Response of S");
//iii
Q = -0.05:0.01:0.05;
colors = ["red", "blue", "green", "cyan", "magenta", "brown", "pink", "black", "royalblue","gold", "violet"];
plotcolors = ["scilabred4", "scilab blue2", "scilab green4", "scilab cyan4",...
"scilabmagenta4", "scilabbrown4", "scilabpink4", "black", "royalblue","gold",...
"dodgerblue1"];
for i=1:size(Q, 2)
   a = Q(i);
   [Num, Den] = simp(s-3+a, s^2-s-6);
   S2 = syslin('c', Num, Den);
   t=0:0.01:10;
   plot2d(t, csim('step', t, S2), style=[color(plotcolors(i))]);
   xgrid(5,0.5,7);
   xlabel("t", 'fontsize', 3);
   ylabel("Step Response");
   title("Step Response of S2 by varying a");
end
set(gca(),"data_bounds",[0,0;10,0.8]);
legend(["a = −0.05","a = −0.04","a = −0.03","a = −0.02","a = −0.01","a = 0","a = 0.01","a = 0.02","a = 0.03","a = 0.04","a = 0.05"]);
//---------------Q2------------------------------//
//i
s = poly(0, 's');
G1 = syslin('c', 85/(s^3+7*s^2+27*s+85));
[Zeros,Poles,Gain] = tf2zp(Gl);
disp(Poles);
G2 = syslin('c',17/(s^2+2*s+17));
t = 0:0.01:10;
plot(t, csim('step', t, G1), 'r-');
plot(t, csim('step', t, G2), 'b-');
xgrid(5,0.5,7);
xlabel("t");
ylabel("Step Response");
title("Step Responses of G1 and G2")
legend(["Original 3rd Order System", "Approximated 2nd Order System"]);
//ii
s = poly(0, 's');
G3 = syslin('c', (s+0.01)/(s^3+(101/50)*s^2+(126/25)*s+0.1));
[Zeros,Poles,Gain] = tf2zp(G3);
disp(Poles);
G4 = syslin('c', 0.5/(s^2+2*s+5));
t = 0:0.01:150;
plot(t, csim('step', t, G3), 'r-');
plot(t, csim('step', t, G4), 'b-');
xgrid(5,0.5,7);
xlabel("t");
ylabel("Step Response");
title("Step Responses of G3 and G4");
set(gca(),"data_bounds",[0,0;150,0.25]);
legend(["Original 3rd Order System (G3)", "Approximated 2nd Order System (G4)"]);
//---------------Q3-------------------//
//a
s = poly(0, 's');
//S1 = syslin('c', 9/(s^2+2*s+9));
//trfmod(S1);
S2 = syslin('c', 9*(s+3)/(s^2+2*s+9));
t = 0:0.01:15;
plot(t, csim('step', t, S1), 'r-');
plot(t, csim('step', t, S2), 'b-');
xgrid(5,0.5,7);
xlabel("t");
ylabel("Step Response");
title("Step Responses of S1 and S2");
legend(["Original System (S1)", "Modified System with a added zero (S2)"]);
//b
Sys = csim('step',t,S2);
steady_value = Sys(size(Sys,2));
peak_value = max(Sys);
OS = 100*(peak_value-steady_value)/steady_value;
disp(OS);
time_rise_h = 0;
time_rise_l = 0;
for i=1:size(Sys, 2)
  if(Sys(i)-(0.1*steady_value)>= 1e-5);
  time_rise_l = t(i);
  break;
  end
end
for i=1:size(Sys, 2)
   if(Sys(i)-(0.9*steady_value)>= 1e-5);
   time_rise_h = t(i);
   break;
   end
end
time_rise = (time_rise_h-time_rise_l);
disp(time_rise);
////////////////////////////////////////////////////////
//OS  = 32.926019
//time_rise  = 0.46
//OS  = 53.296817
//time_rise  = 0.26
///////////////////////////////////////////////////////
//c
s = poly(0, 's');
S3 = syslin('c', 9/((s+0.1)*(s^2+2*s+9)));
S4 = syslin('c', 9/((s+12)*(s^2+2*s+9)));
t = 0:0.01:100;
plot(t, csim('step', t, S3), 'r-');
plot(t, csim('step', t, S4), 'b-');
xgrid(5,0.5,7);
xlabel("t");
ylabel("Step Response");
title("Step Responses of S3 and S4");
set(gca(),"data_bounds",[0,0;150,15]);
legend(["Modified System with a added pole near origin (S3)", "Modified System with a added pole far from origin (S4)"]);
///////////////////////////////////////////////////////
//OS = 0.
//time_rise = 10.99
//OS  = 31.831842
//time_rise = 0.48
///////////////////////////////////////////////////////
//----------------------Q4-----------------------//
s = poly(0,'s');
z1 = 3/8;
z2 = 9/2;
T1 = syslin('c', 1/(s^2+1));
T2 = syslin('c', 1/(s^2+z1*s+1));
T3 = syslin('c', 1/(s^2+z2*s+1));
t=0:0.01:30;
plot(t, csim('step', t, T1), 'r-','Linewidth',2);
plot(t, csim('step', t, T2), 'g-','Linewidth',2);
plot(t, csim('step', t, T3), 'b-','Linewidth',2);
xgrid(5,0.5,7);
xlabel("t");
ylabel("Step Response");
title("Step Responses of T1, T2 and T3");
legend(["Undamped System", "Underdamped System", "Overdamped System"]);
time_peak1 = 3.14/sqrt(1-(z1)^2);
time_settle1= 4/z1
Sys = csim('step',t,T1);
steady_value = Sys(size(Sys,2));
peak_value = max(Sys);
time_peak=0;
for i=1:size(Sys, 2)
   if(Sys(i)-(peak_value)<= 1e-5);
   time_peak = t(i);
   break;
   end
end
OS = 100*(peak_value-steady_value)/steady_value;
disp(OS);
time_delay = 0
for i=1:size(Sys, 2)
   if(Sys(i)-(0.5*steady_value)<= 1e-5)
   time_delay = t(i);
   break;
   end
end
disp(time_delay);
time_rise_h = 0;
time_rise_l = 0;
for i=1:size(Sys, 2)
  if(Sys(i)-(0.1*steady_value)>= 1e-5);
  time_rise_l = t(i);
  break;
  end
end
for i=1:size(Sys, 2)
   if(Sys(i)-(0.9*steady_value)<= 1e-5);
   time_rise_h = t(i);
   break;
   end
end
time_rise = (time_rise_h-time_rise_l);
disp(time_rise);
time_s=();
for i=1:size(Sys, 2)
   if(Sys(i)-(0.98*steady_value)<= 1e-5);
   time_s($+1) = t(i);
   break;
   end
end
time_settle = time_s(size(time_s));
disp(time_settle);
///////////////////////////////////////////////////
//overshoot, peak time, delay time, rise time, 2% settling time
//1 -%  3.14s 0.96s 0.91s -
//2 54.59% 3.27s 1.13s 1.19s 10.66s
//3 0s infi 2.38s 8.36s 16.53s
//////////////////////////////////////////////////
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
    plot(k, time_settle, 'g');
    xlabel("K");
    ylabel("Settling Time (Ts)");
    title("Settling Time (Ts) for K as 1 to 1000");
    steady_error = 1 / (1 + k/(3 * 4 * 12));
    errors = [errors, steady_error];
end








