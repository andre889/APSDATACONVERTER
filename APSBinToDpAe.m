%Author: Austin Andrews
%Date: 5/30/2021
%Email: andre889@umn.edu
%
%This function outputs the bin number 'N' and corresponding Aerodynamic
%equivalent diameter 'Dae'. 'Dae_corrected' includes the density corrects
%as proposed by https://doi.org/10.1080/02786828708959132 eq 8.
%'Dae_uncorrected' is the diamter based on the original calibration without
%density correction. 
% Assuming STP-Air for all gas properties. 
%Inputs:
%particle density 'rhop' [kg/m^3]
%'APS_CalibrationData' is a structure with a 3rd order polynomial fit of
%the TSI calibration data. 

function [N, Dae_corrected, Dae_uncorrected] = APSBinToDpAe(rhop,APS_CalibrationData)

if nargin<2
    APS3321_SN71841024.a = 1.119590000000000e-05;
    APS3321_SN71841024.b = 0.011126322000000;
    APS3321_SN71841024.c = -2.160160468000000;
    APS3321_SN71841024.detectionEff = [0.353519801000000,50;0.410902726000000,72.300000000000000;0.522594489000000,84.900000000000000;0.719335944000000,96.200000000000000];
    APS_CalibrationData = APS3321_SN71841024;
end 

%instrument specific?
L = 120e-6; %laser beam distance in um
U = 150; %m/s at laser??

%input is channel number
N = [1:1:1024];
T = 1e-9*(N*4.0-2.0);

Vbar = L./T;
mu = 1.81e-5; % air viscosity 
rhoa = 1.225; %air density
rho1 = 1050;  %calibration aerosol density assuming PSL
rho2 = rhop;

%based on calibration
Dae1 = 1e-6*(APS_CalibrationData.a.*N.^2 + APS_CalibrationData.b.*N + APS_CalibrationData.c);
error = 10;
Dae2 = Dae1;
iter = 0;

while(error > 1e-10 && iter < 1000)
R1 = (rhoa/mu).*(U-Vbar).*(Dae1)./sqrt(rho1/1000);
R2 = (rhoa/mu).*(U-Vbar).*(Dae2)./sqrt(rho2/1000);

R1(R1 < 0 ) = 0;
R2(R2 < 0 ) = 0;

R2P = R2.^(2.0/3.0);
R1P = R1.^(2.0/3.0);

Dae2new = Dae1.*((6.0+R2P)./(6.0+R1P)).^(1.0/2.0);
e1 = (1e6*Dae1-1e6*Dae2new).^2;
error = sum((1e6*Dae2-1e6*Dae2new).^2);
omega = 0.9;
Dae2 = omega*Dae2new + (1-omega)*Dae2;
iter = iter +1;
end
%disp('done in')
%disp(iter);

%plot(N,Dae2*1e6);

Dae_uncorrected = Dae1*1e6;
Dae_corrected = Dae2*1e6;
end