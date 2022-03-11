%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Example script to use APS functions
% Author: Austin Andrews
% Date: 03/11/20222
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Currently can do density corrections, but not transmission losses of
% either the dilutor or instrument itself. 
%% Settings and Perameters
rhop = 1000; %particle density in kg/m^3. If not known use water~=1000
timeOfSample = 5; %Sample time in seconds for each sample
binReduction = 4; %factor of bin reduction. 1 is no reduction. 20 is close to what  TSI uses, but not quite since they group smaller bins together. 
%% Load Data

%data = X;

%% Obtain aerodynamic diameters (dAe) from abs calibration (dAeCorrected) with possible density correction (dAeUncorrected)  
[N, dAeUncorrected] = APSBinToDpAe();

dAeCorrected = APSDensityCorrection(rhop,dAeUncorrected);
%% Convert raw counts to concentration 

concentration = rawToConcentration(data,timeOfSample); %units in #/cc

%% Convert concentration to distrubtion function
dndLogdp = concentrationToDist(concentration,dAeCorrected);

%% Plot results
figure
box on
hold on
plot(dAeCorrected*1e6,dndLogdp)
plot(dAeUncorrected*1e6,dndLogdp)
xlim([0.5 20])
set(gca,'xscale','log')
xticks([0.5 0.7 1 2 3 5 7 10 20]);
xlabel('Aerodynamic Particle Size [\mum]')
ylabel('Size Distribution [dn/dlogdp]')
hold off

%% reduce bins WARNING EXPERIMENTAL NON TESTED
[dBinEdges c] = reduceBins(binReduction,dAeUncorrected,data);

figure
hold on
for i = 1:length(c)
    if( dBinEdges(i) > 0.5e-6)
        plot(polyshape([dBinEdges(i) dBinEdges(i) dBinEdges(i+1) dBinEdges(i+1)].*1e6,[c(i) 0 0 c(i)]),'FaceColor','b');
    end
end
xlabel('Aerodynamic Particle Size [\mum]')
ylabel('# particles')
set(gca,'xscale','log')
xticks([0.5 0.7 1 2 3 5 7 10 20]);
xlabel('Aerodynamic Particle Size [\mum]')
xlim([0.5 20])
hold off