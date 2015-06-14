%generate the subkey

function h=deskg(xl,xr)
h=zeros(48*16,1);
for i=1:16
    switch i
        case 1
        case 2
        case 9
        case 16
                xl=[xl(2:28) xl(1)];
                xr=[xr(2:28) xr(1)];
                w=[xl xr];
                h((i-1)*48+1:i*48)=[w(14) w(17) w(11) w(24) w(1) w(5) w(3) w(28) w(15) w(6) w(21) w(10) w(23) w(19) w(12) w(4) w(26) w(8) w(16) w(7) w(27) w(20) w(13) w(2) w(41) w(52) w(31) w(37) w(47) w(55) w(30) w(40) w(51) w(45) w(33) w(48) w(44) w(49) w(39) w(56) w(34) w(53) w(46) w(42) w(50) w(36) w(29) w(32)];
    otherwise
                xl=[xl(3:28) xl(1) xl(2)];
                xr=[xr(3:28) xr(1) xr(2)];
                w=[xl xr];
                h((i-1)*48+1:i*48)=[w(14) w(17) w(11) w(24) w(1) w(5) w(3) w(28) w(15) w(6) w(21) w(10) w(23) w(19) w(12) w(4) w(26) w(8) w(16) w(7) w(27) w(20) w(13) w(2) w(41) w(52) w(31) w(37) w(47) w(55) w(30) w(40) w(51) w(45) w(33) w(48) w(44) w(49) w(39) w(56) w(34) w(53) w(46) w(42) w(50) w(36) w(29) w(32)];    
    end


end