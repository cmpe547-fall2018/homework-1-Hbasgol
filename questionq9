function questionq9

% Answer for Q9 from booklet
% It finds the conditional probabilities of diceA, diceB and diceC given
% observation and observation2 and it draws DAG for each answer.

import brml.*

disp("First Question and its DAG, press a key to continue"); pause();

diceA = 2;  diceB = 3; Observation = 1;
diceAvar = [6 4 3 2 1 1 1 1 1 0];
diceBvar = [3 3 2 2 2 2 2 2 1 1];
observation = [5, 3, 9, 3, 8, 4, 7];

variable(diceA).name="diceA"; 
variable(diceA).domain={1:10};

variable(diceB).name="diceB"; 
variable(diceB).domain={1:10};

pot(diceA)=array; 
pot(diceA).variables=diceA;

pot(diceB)=array;
pot(diceB).variables=diceB;

for i = 1:10
    pot(diceA).table(i) = diceAvar(i)/sum(diceAvar);
    pot(diceB).table(i) = diceBvar(i)/sum(diceBvar);
end

variable(Observation).name="observation";
variable(Observation).domain = (1:7);
pot(Observation)= array;
pot(Observation).variables=[Observation, diceA, diceB];

for i = 1:length(observation)
    for j = 1:length(diceAvar)
        for k = 1:length(diceBvar)
            pot(Observation).table(i, j, k)=pot(diceA).table(j)*pot(diceB).table(k);
        end
    end
end

resultA = 1; resultB = 1;
for i = 1:length(observation)
    x = observation(i);
    resultA = pot(diceA).table(x)*resultA;
    resultB = pot(diceB).table(x)*resultB;
end

probA = resultA /(resultB + resultA);
disp(['P(A|observation): ', num2str(probA)])

drawNet(dag(pot),variable);

disp("Second Question and its DAG, press a key to continue")
pause();

diceC = 4;
variable(diceC).name="diceC";
variable(diceC).domain={1:20};
diceCvar = ones(1,20);
pot(diceC)=array;
pot(diceC).table=diceCvar;
pot(diceC).table = pot(diceC).table/sum(pot(diceC).table);
pot(Observation).variables=[Observation, diceA, diceB, diceC];

observation2 = [3, 5, 4, 8, 3, 9, 7];
resultA = 1; resultB = 1; resultC = 1;

for i = 1:length(observation2)
    x = observation2(i);
    resultA = pot(diceA).table(x)*resultA;
    resultB = pot(diceB).table(x)*resultB;
    resultC = pot(diceC).table(x)*resultC;
end

normalization = resultA + resultB + resultC;
probA = resultA / normalization;
probB = resultB / normalization;
probC = resultC / normalization;

drawNet(dag(pot),variable);
disp(['P(A|observation2): ', num2str(probA), newline, 'P(B|observation2): ', num2str(probB), newline, 'P(C|observation2): ', num2str(probC)])
