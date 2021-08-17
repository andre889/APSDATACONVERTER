rhop = 1000;
% load APS3321_SN71841024
% APSCalibration = APS3321_SN71841024;
[N, Dae_corrected, Dae_uncorrected] = APSBinToDpAe(rhop);


Dilution = 100;

res = rawToConcentration(swImpingerRaw(2,:),30)*Dilution;
%%
plome = concentrationToDist(res,Dae_uncorrected);

figure
hold on
plot(Dae_uncorrected, plome,'k')
%plot(Dae_corrected, data)
% plot(data2(1,:),data2(2,:))
% plot(Dae,Data/max(Data([200:1024])),'k')
% plot(ELPI(:,1),ELPI(:,2)/max(ELPI([5:12],2)),'--ksq','markerfacecolor','r')
hold off
xlim([0.5 20])
set(gca,'xscale','log')
xticks([0.5 0.7 1 2 3 5 7 10 20]);
xlabel('Aerodynamic Particle Size [\mum]')
ylabel('Size Distribution [dn/dlogdp]')
%title('Iron Salt 0.25 g/L solution')


%%

% sum betwee 0 and 3 um
sw03um = sum(swImpingerRaw(:,and(Dae_uncorrected > 0.5,Dae_uncorrected < 3)),2);
sw320um = sum(swImpingerRaw(:,and(Dae_uncorrected > 3,Dae_uncorrected < 20)),2);

figure

hold on
plot(swImpingerTime/60,rawToConcentration(sw03um,30))
plot(swImpingerTime/60,rawToConcentration(sw320um,30))
legend('0.5 to 3 um','3 to 20 um')
xlabel('Time [min]')
ylabel('Concentration [#/cc]')
hold off

%% puffs


%figure of all charge data
t1 = [6:24];
t2 = [31:47];
t3  = [47:68];
t4 = [71:87];
t5 = [87:104];
sample1Charge = puffData(t1,:);
sample2Charge = puffData(t2,:);
sample3Charge = puffData(t3,:);
sample4Charge = puffData(t4,:);
sample5Charge = puffData(t5,:);



%Colors?

figure

hold on

plot(t1,sample1Charge)
plot(t2,sample2Charge)
plot(t3,sample3Charge)
plot(t4,sample4Charge)
plot(t5,sample5Charge)
xlabel('Time [s]')
ylabel('Current [fA]') %-15

hold off


%Charge per channel1.6e-19
charge1([1:12]) = trapz(t1,sample1Charge(:,[1:12])*1e-15)/1e-12;
charge2([1:12]) = trapz(t2,sample2Charge(:,[1:12])*1e-15)/1e-12;
charge3([1:12]) = trapz(t3,sample3Charge(:,[1:12])*1e-15)/1e-12;
charge4([1:12]) = trapz(t4,sample4Charge(:,[1:12])*1e-15)/1e-12;
charge5([1:12]) = trapz(t5,sample5Charge(:,[1:12])*1e-15)/1e-12;

dp50  = [0.063	0.109	0.173	0.267	0.407	0.655	1.021	1.655	2.52	4.085	6.56	9.99];

figure
hold on

plot(dp50,charge1,'--Sqk','MarkerFaceColor','k')
plot(dp50,charge2,'--^k','MarkerFaceColor','k')
plot(dp50,charge3,'--ok','MarkerFaceColor','k')
plot(dp50,charge4,'--*k','MarkerFaceColor','k')
plot(dp50,charge5,'--+k','MarkerFaceColor','k')

set(gca,'xscale','log')
xticks([0.1 0.3 1 3 10]);
xlabel('Aerodynamic Particle Size [\mum]')
hold off
xlabel('Aerodynamic Diameter [um]')
ylabel('Charge [pC]')

