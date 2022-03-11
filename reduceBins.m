%Author: Austin Andrews
%Date: 03/11/2022
%Email: andre889@umn.edu
% This function takes in data (Raw particle counts)
%in the APS and reduces it by some binReduction factor
%outputs edges of bins and new values 'c' 
%The orignal 1024 bins have a width to them as well, but for now ignoring
%it. 
% WARNING EXPERIMENTAL NON TESTED
function [dBinEdges c] = reduceBins(binReduction,dia,data)
 if(~(length(dia) == length(data)))
          disp("Lengths of dia and data do not match in reduceBins!");
     return
 end
 if(~(mod(length(data),binReduction) == 0))
      disp("BinReduction in function reduceBins is not a factor or data size: " + num2str(length(data)) + "!");
     return
 end

 newDataCount = (length(data))/binReduction;

 dBinEdges = zeros(1,newDataCount+1);
 c = zeros(1,newDataCount);
 dBinEdges(1) = dia(1); % this is an approximation 

 stride = 1;
 stride = stride + binReduction;
 for i = 2:newDataCount-1
     dBinEdges(i) = 0.5*(dia(stride) + dia(stride-1)); % this is an approximation 
    stride = stride + binReduction;
 end
dBinEdges(end) = dia(end); %this is an approximation

 stride = 1;
 for i = 1:newDataCount
     c(i) = sum(data([stride:stride+binReduction-1]));
     stride = stride + binReduction;
 end

 

end