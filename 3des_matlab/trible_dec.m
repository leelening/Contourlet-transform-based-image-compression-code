%one round for des encryption

function Data=trible_des(temp,kf)
r=temp;
%initial permutation
m=[r(58) r(50) r(42) r(34) r(26) r(18) r(10) r(2) r(60) r(52) r(44) r(36) r(28) r(20) r(12) r(4) r(62) r(54) r(46) r(38) r(30) r(22) r(14) r(6) r(64) r(56) r(48) r(40) r(32) r(24) r(16) r(8) r(57) r(49) r(41) r(33) r(25) r(17) r(9) r(1) r(59) r(51) r(43) r(35) r(27) r(19) r(11) r(3) r(61) r(53) r(45) r(37) r(29) r(21) r(13) r(5) r(63) r(55) r(47) r(39) r(31) r(23) r(15) r(7)]; 
for i=16:-1:1
    t=encryption(m,i,kf);
    m=t;
end
m1=m(1:32);
m2=m(33:64);
d=[m2 m1];
Data=[d(40) d(8) d(48) d(16) d(56) d(24) d(64) d(32) d(39) d(7) d(47) d(15) d(55) d(23) d(63) d(31) d(38) d(6) d(46) d(14) d(54) d(22) d(62) d(30) d(37) d(5) d(45) d(13) d(53) d(21) d(61) d(29) d(36) d(4) d(44) d(12) d(52) d(20) d(60) d(28) d(35) d(3) d(43) d(11) d(51) d(19) d(59) d(27) d(34) d(2) d(42) d(10) d(50) d(18) d(58) d(26) d(33) d(1) d(41) d(9) d(49) d(17) d(57) d(25)]; %inverse initial permutation
