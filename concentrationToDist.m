%This program converts from concentration to log based distriubtion
%Output is in #/cc
%sampleTime is in seconds

function dist = concentrationToDist(concentration, dp)
    dist = zeros(1,length(dp));
    for(i = 1:length(dp)-1)
        dist(i) =concentration(i)/(log10(dp(i+1)/dp(i)));
    end
    dist(length(dp)) = concentration(length(dp))/(log10(dp(length(dp))/dp(length(dp)-1)));

end