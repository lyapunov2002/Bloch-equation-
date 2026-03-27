clear; clc; close all; 
%%-------------------------------------------------------------------------
%% Parametri
T2 = 0.08;
T1 = 0.6;

gamma = 2*pi*42.58e6;    % Rapporto giromagnetico rad/s/T 
                         % (nota bene tali valori possono essere modificati a piacimento per visualizzare particolari evoluzioni
                         %  autonome del vettore (Mx,My,Mz)
B0 = 10^(-6);            % T piccolo per vedere bene l'oscillazione
%%-------------------------------------------------------------------------
%% Matrice di stato
A = [-1/T2,gamma*B0;-gamma*B0, -1/T2]; %Matrice della dinamica del sistema disaccoppiato nel piano (x,y)
%%-------------------------------------------------------------------------
%% Sistema (uscita irrilevante)
sys = ss(A,[],[],[]);   % [] lo uso perchè preferisco invece del definire matrici di 0 e usarle successivamente tale comando è equivalente 
%%-------------------------------------------------------------------------
%% Condizione iniziale
x0 = [0;1]; 
%%-------------------------------------------------------------------------
%% Tempo
t = linspace(0,0.3,1000);
t1 = linspace(0,3,1000);

%%-------------------------------------------------------------------------
%% Simulo il sistema LTI ma solo nello stato
[~,t,x] = initial(sys,x0,t);

Mx = x(:,1);
My = x(:,2);
z = @(t1) 1-exp(-t1/T1);
Mz=z(t1);

%%-------------------------------------------------------------------------
%%plotto Mx(t) ed My(t)
figure ;
plot(t,Mx,'LineWidth',1); hold on;
plot(t,My,'LineWidth',1);
grid on;
xlabel('t [s]');
ylabel('Magnetizzazione xy');
legend('M_x','M_y');
title('Evoluzione temporale');

%%-------------------------------------------------------------------------
%%plotto Mz(t);
figure ;
plot(t,Mz,'LineWidth',1);hold on;
grid on
xlabel('t [s]');
ylabel('Magnetizzazione z');
title('Evoluzione temporale');

%%-------------------------------------------------------------------------
%%phase plane xy
figure ;
plot(Mx,My,'LineWidth',1);
grid on;
xlabel('M_x');
ylabel('M_y');
title('Piano delle fasi');
axis equal;
%%-------------------------------------------------------------------------
%%phase space xyz
figure;
plot3(Mx,My,Mz);
grid on;