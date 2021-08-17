%This program converts from raw counts to number concentration given the
%APS is running at std flows 5 LPM total with 1LPM aersol Flow
%Output is in #/cc
%sampleTime is in seconds

function concentration = rawToConcentration(counts, sampleTime)
    
    concentration = counts./(83.3333333333333.*sampleTime/5);

end