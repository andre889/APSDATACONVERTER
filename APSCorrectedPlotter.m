%clear

rhop = 1897;
% load APS3321_SN71841024
% APSCalibration = APS3321_SN71841024;
[data] = APSDataReader;
[N, Dae_corrected, Dae_uncorrected] = APSBinToDpAe(rhop);



figure
hold on
plot(Dae_corrected/sqrt(rhop/1000), data(5,:),'k')
%plot(Dae_corrected, data)
% plot(data2(1,:),data2(2,:))
% plot(Dae,Data/max(Data([200:1024])),'k')
% plot(ELPI(:,1),ELPI(:,2)/max(ELPI([5:12],2)),'--ksq','markerfacecolor','r')
hold off
xlim([0.5 20])
set(gca,'xscale','log')
xticks([0.5 0.7 1 2 3 5 7 10 20]);
xlabel('Geometric Particle Size [\mum]')
ylabel('Raw Counts per 1 min')
title('0.025 g/L solution')
%title('Iron Salt 0.25 g/L solution')