function questionq26

% This is the answer for Q26 from booklet. It takes a probability table 
% as a matrix and computes Expectations, Joint Entropy, Marginal Entropies,
% Conditional Entropies, and Mutual Information. 

import brml.*

% INPUTS
X = 1; Y = 2; PXY = 3;
Xstates = input('Please enter states of X as [x1 x2 x3...]: ');
Ystates = input('Please enter states of Y as [y1 y2 y3...]: ');
Pxy = input('Please enter P(X,Y) as a matrix as [x1y1 x1y2 x1y3; x2y1 x2y2 x2y3...]: ');

variable(X).name='X'; variable(X).domain = {Xstates};
variable(Y).name='Y'; variable(Y).domain ={Ystates};

pot(PXY)=array;
pot(PXY).variables=[X, Y];

for j = 1:length(Xstates)
    for i = 1:length(Ystates)
        pot(PXY).table(j, i) = Pxy(j, i);
    end
end

% Expectations
Ex = 0;
for i = 1:length(Xstates)
    Ex = sum(pot(PXY).table(i,:))*Xstates(i) + Ex;
end

Ey = 0;
for i = 1:length(Ystates)
    Ey = sum(pot(PXY).table(:, i))*Ystates(i) + Ey;
end

%Conditional Expectations
Exgiveny = [];
Exgivenyt = 0;
for i = 1:length(Ystates)
    Exgivenyt = sum(Xstates*pot(PXY).table(:, i));
    Exgiveny = [Exgiveny, Exgivenyt];
end

Eygivenx = [];
Eygivenxt = 0;
for i = 1:length(Xstates)
    Eygivenxt = sum(Ystates.*pot(PXY).table(i, :));
    Eygivenx = [Eygivenx, Eygivenxt];
end

%Covariance
covxy = [];
covxy2 = [];

for i = 1:length(Ystates)
    covxyt = Xstates'.*pot(PXY).table(:, i);
    covxy = [covxy, covxyt];
end

for j = 1:length(Xstates)
    covxy2t = Ystates.*covxy(j, :);
    covxy2 = [covxy2, covxy2t];
end

covxy = sum(covxy2) - (Ex*Ey);

% Joint Entropy
logPotD = pot(PXY).table;
logPotD(logPotD == 0) = 1;
logPot = log(logPotD);

logPotxy = [];
for i = 1:length(Ystates)
    logPotxyt = Xstates'.*logPot(:, i);
    logPotxy = [logPotxy, logPotxyt];
end

logPotxy2 = [];
for j = 1:length(Xstates)
    logPotxy2t = Ystates.*logPotxy(j, :);
    logPotxy2 = [logPotxy2, logPotxy2t];
end
logPotxy2 = sum(logPotxy2);

% Marginal Entropies
logPoteX = 0;
for i = 1:length(Xstates)
    logPoteX = sum(logPot(i,:))*Xstates(i) + logPoteX;
end

logPoteY = 0;
for i = 1:length(Ystates)
    logPoteY = sum(logPot(:, i))*Ystates(i) + logPoteY;
end

% Conditional Entropies
EntrExgiveny = [];
EntrExgivenyt = 0;
for i = 1:length(Ystates)
    EntrExgivenyt = sum(Xstates*logPot(:, i));
    EntrExgiveny = [EntrExgiveny, EntrExgivenyt];
end

EntrEygivenx = [];
EntrEygivenxt = 0;
for i = 1:length(Xstates)
    EntrEygivenxt = sum(Ystates.*logPot(i, :));
    EntrEygivenx = [EntrEygivenx, EntrEygivenxt];
end

% Mutual Information 
Ixy = logPoteX - EntrExgiveny;

% OUTPUTS
disp("Expectations");
fprintf("E[X]: %.3f", Ex);
fprintf("\nE[Y]: %.3f", Ey);

fprintf("\n\nConditional Expectations");
for i = 1:length(Ystates)
    fprintf("\nE[X|Y=%d]: %.3f", Ystates(i), Exgiveny(i));
end
for i = 1:length(Xstates)
    fprintf("\nE[Y|X=%d]: %.3f", Xstates(i), Eygivenx(i));
end

fprintf("\n\nCovariance");
fprintf("\nCov(X,Y): %.3f", covxy);

fprintf("\n\nJoint Entropy");
fprintf("\nH(X,Y): %.3f", -1 * logPotxy2);

fprintf("\n\nMarginal Entropies");
fprintf("\nH(X): %.3f",  -1 * logPoteX);
fprintf("\nH(Y): %.3f",  -1 * logPoteY);

fprintf("\n\nConditional Entropies");
for i = 1:length(Ystates)
    fprintf("\nE[X|Y=%d]: %.3f", Ystates(i), -1 * EntrExgiveny(i));
end
for i = 1:length(Xstates)
    fprintf("\nE[Y|X=%d]: %.3f", Xstates(i), -1 * EntrEygivenx(i));
end

fprintf("\n\nMutual Information");
for i = 1:length(Ystates)
    fprintf("\nI(X,Y=%d): %.3f", Ystates(i), Ixy(i));
end
