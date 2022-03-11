%Author: Austin Andrews
%Date: 5/30/2021
%Email: andre889@umn.edu
%Modification made 3/11/2021 to organize code better. 
%This function outputs the bin number 'N' and corresponding Aerodynamic
%equivalent diameter 'Dae'. 'Dae_corrected' includes the density corrects
%as proposed by https://doi.org/10.1080/02786828708959132 eq 8.
%'Dae_uncorrected' is the diamter based on the original calibration without
%density correction. 
% Assuming STP-Air for all gas properties. 
%Inputs:
%'APS_CalibrationData' is a structure with a 3rd order polynomial fit of
%the TSI calibration data. Calibrations are done for um units  
%All units are in Standard SI units, kg, m, s, K and so on 
%**IMPORTANT!*** output is in um!

%Outputs sizes(Dae_corrected) in um and channel numbers (N)
function [N, Dae_uncorrected] = APSBinToDpAe(APS_CalibrationData)

if nargin<1
    APS3321_SN71841024.a = 1.119590000000000e-05;
    APS3321_SN71841024.b = 0.011126322000000;
    APS3321_SN71841024.c = -2.160160468000000;
    APS3321_SN71841024.detectionEff = [0.353519801000000,50;0.410902726000000,72.300000000000000;0.522594489000000,84.900000000000000;0.719335944000000,96.200000000000000];
    APS_CalibrationData = APS3321_SN71841024;
end 

N = [1:1:1024];

%based on calibration
Dae1 = 1e-6*(APS_CalibrationData.a.*N.^2 + APS_CalibrationData.b.*N + APS_CalibrationData.c);

Dae_uncorrected = Dae1;
end