function voltsArray = hexToMicroVolts(splitLine)
ADS1299_Vref = 4.5;
ADS1299_gain = 24.0;


factorEEG=ADS1299_Vref / (2.^23-1) / ADS1299_gain*1000000;
factorAUX=0.002 / (power(2,4));


for i=2:length(splitLine)
    value=splitLine{i};
    if(i<=17)
        
        if(value(1) > '7')
            value=shex2dec(['FF' value]);
        else
            value=shex2dec(['00' value]);
        end
        value=value*factorEEG;
        
    else
        if(value(1) == 'F')
            value=shex2dec(['FF' value]);
        else
            value=shex2dec(['00' value]);
        end
        value=value*factorAUX;
        
    end
    
    voltsArray(i-1)=value;
      
end

