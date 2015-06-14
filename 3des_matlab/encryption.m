 %one round for trible des encryption

function sw=desencryption(m,r,kf)
yl=m(1:32);
yr=m(33:64);
%expansion and permutation
x=[yr(32) yr(1) yr(2) yr(3) yr(4) yr(5) yr(4) yr(5) yr(6) yr(7) yr(8) yr(9) yr(8) yr(9) yr(10) yr(11) yr(12) yr(13) yr(12) yr(13) yr(14) yr(15) yr(16) yr(17) yr(16) yr(17) yr(18) yr(19) yr(20) yr(21) yr(20) yr(21) yr(22) yr(23) yr(24) yr(25) yr(24) yr(25) yr(26) yr(27) yr(28) yr(29) yr(28) yr(29) yr(30) yr(31) yr(32) yr(1)];

k=kf((r-1)*48+1:r*48);
z=xor(k',x);
for i=1:8
    Arg=z((i-1)*6+1:i*6);
    q((i-1)*4+1:i*4)=sbox(Arg,i);
end
%permutation function
n=[q(16) q(7) q(20) q(21) q(29) q(12) q(28) q(17) q(1) q(15) q(23) q(26) q(5) q(18) q(31) q(10) q(2) q(8) q(24) q(14) q(32) q(27) q(3) q(9) q(19) q(13) q(30) q(6) q(22) q(11) q(4) q(25)];
g=xor(n,yl);
sw=[yr g];



    