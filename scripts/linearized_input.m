Tw = 6;
Cd = 180;
Csh = 30;
K = 3.1616;
TAUf = 5;
Tf = 8;
Pd_const = 1.025;
Pt_const = 1;
CV = 0.5;
SIG = 0.5;

% A1 = [-1/Tf 0 0 0; 
%        1/Tw -1/Tw 0 0;
%         0 0 K/(Csh*2*sqrt(Pd_const-Pt_const))-CV/Csh K/(Csh*2*sqrt(Pd_const-Pt_const));
%         0 1/Cd -K/(Cd*2*sqrt(Pd_const-Pt_const)) -K/(Cd*2*sqrt(Pd_const-Pt_const))];
% B1 = [1/Tf 0;
%       0 0;
%       0 Pt_const/Csh;
%       0 0];
% C1 = [0 0 CV 0;
%       0 0 0 1];
% D1 = [0 1; 
%      0 0];

alpha = K/(2*sqrt(Pd_const-Pt_const));
% 
% A1 = [-1/Tf 0 0 0; 
%        1/Tw -1/Tw 0 0;
%         0 1/Csh (-alpha)/Csh alpha/Csh;
%         0 1/Cd -alpha/Cd alpha/Cd];
% B1 = [(1)/Tf 0;
%       0 Pt_const;
%       0 CV/Csh;
%       0 CV/Cd];


%A1 = [-1/Tf 0 0 0; 
%       1/Tw -1/Tw 0 0;
%        0 0 (-alpha/Csh)-(CV/Csh) alpha/Csh;
%        0 1/Cd +alpha/Cd -alpha/Cd];
%B1 = [1/Tf 0;
%      0 0;
%      0 -(Pt_const/Csh);
%      0 0];
%C1 = [0 0 CV 0;
%      0 0 0 1];
%D1 = [0 1; 
%     0 0];


% Macierze stanu
A1 = [-1/Tf     0              0                  0;
       1/Tw   -1/Tw            0                  0;
         0      0    (-alpha/Csh)-(CV/Csh)     alpha/Csh;
         0    1/Cd          +alpha/Cd         -alpha/Cd];

B1 = [1/Tf       0;
       0         0;
       0   -(Pt_const/Csh);
       0         0];

C1 = [0 0 CV 0;
      0 0 0 1];

D1 = [0 0; 
     0 0];

% Utworzenie obiektu modelu stanu
sys = ss(A1, B1, C1, D1);

% Dyskretyzacja
Ts = 1;  % czas próbkowania
sysd = c2d(sys, Ts, 'zoh');

% Utworzenie obiektu kontrolera MPC
mpcobj = mpc(sysd, Ts);

% Konfiguracja horyzontów predykcji i sterowania
mpcobj.PredictionHorizon = 10;
mpcobj.ControlHorizon = 2;

% Wagi (można dostosować wg potrzeb)
mpcobj.Weights.ManipulatedVariables = [0.1 0];               % tylko wejście 1 to sterowanie
mpcobj.Weights.ManipulatedVariablesRate = [0.1 0];
mpcobj.Weights.OutputVariables = [1 1];                      % MS i Pd

% Ograniczenia na wejścia (opcjonalnie)
mpcobj.MV(1).Min = -1;
mpcobj.MV(1).Max = 1;
mpcobj.MV(2).Min = -Inf;  % wejście 2 traktujemy jako zakłócenie (jeśli nie sterowane)
mpcobj.MV(2).Max = Inf;