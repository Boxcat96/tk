% Two steady states
% cRhoR_val = [0 0.75];
% 
close all;
cBETA = 0.995;
PiVec = 0.9925:0.001:1.0025;
cRELB = 1;
cPHIpi = 2;

FR  = 1/cBETA*PiVec;
TTR = max(cRELB,1/cBETA*PiVec.^cPHIpi)


figure(1)
plot(PiVec,FR,'k','LineWidth',2)
hold on
plot(PiVec,TTR,'r','LineWidth',2)
legend('Fisher Relation','Truncated Taylor Rule','Location','NorthWest','FontSize',16)
xlabel('Inflation','FontSize',16)
ylabel('Nominal interest rate','FontSize',16)
xlim([min(PiVec) max(PiVec)])
