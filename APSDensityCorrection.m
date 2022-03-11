%Author: Austin Andrews
%Date: 5/30/2021
%Modification made 3/11/2021 to organize code better. 
%Email: andre889@umn.edu
%
%This function outputs a corrected particle size 'Dae_corrected' 
%as proposed by https://doi.org/10.1080/02786828708959132 eq 8.
%'Dae_uncorrected' is the diamter based on the original calibration without
%density correction. 
% Assuming STP-Air for all gas properties. 
%Inputs:
%particle density 'rhop' [kg/m^3]
%Original particle sizes Dae_uncorrected in [m]
%All units are in Standard SI units, kg, m, s, K and so on 
%This function should be split into two, one giving uncorrected Diameters
%and the other appling the correcting in https://doi.org/10.1080/02786828708959132

function [Dae_corrected] = APSDensityCorrection(rhop,Dae_uncorrected)
    if(Dae_uncorrected(end) > 1.0)
     disp(["Dae_uncorrected(end) in function APSDensityCorrection is greater than one! " + num2str(Dae_uncorrected(end)) + "\n This is likely due to incorrect units. Please use [m] for this funciton"]);
     return
    end
    %instrument specific? For now using values from https://doi.org/10.1080/02786828708959132
    L = 120e-6; %laser beam distance
    U = 150; %m/s at laser??
    
    N = [1:1:1024]; %channels in APS
    T = 1e-9*(N*4.0-2.0); % Time of flight for each channel
    
    Vbar = L./T; %Average particle velocity for each bin
    
    %Gas properties
    mu = 1.81e-5; % air viscosity 
    rhoa = 1.225; %air density

    rho1 = 1050;  %calibration aerosol density assuming PSL
    rho2 = rhop;
    Dae1 = Dae_uncorrected;
    error = 10;
    Dae2 = Dae_uncorrected;
    iter = 0;
    
    while(error > 1e-10 && iter < 1000)
    R1 = (rhoa/mu).*(U-Vbar).*(Dae1)./sqrt(rho1/1000);
    R2 = (rhoa/mu).*(U-Vbar).*(Dae2)./sqrt(rho2/1000);
    
    R1(R1 < 0 ) = 0;
    R2(R2 < 0 ) = 0;
    
    R2P = R2.^(2.0/3.0);
    R1P = R1.^(2.0/3.0);
    
    Dae2new = Dae1.*((6.0+R2P)./(6.0+R1P)).^(1.0/2.0);
    
    error = sum((1e6*Dae2-1e6*Dae2new).^2);
    
    %apply relaxation
    omega = 0.9;
    Dae2 = omega*Dae2new + (1-omega)*Dae2;
    iter = iter +1;
    end
    
    %Visual Debugging
    %disp('done in')
    %disp(iter);
    %plot(N,Dae2*1e6);
   
    Dae_corrected = Dae2;
end