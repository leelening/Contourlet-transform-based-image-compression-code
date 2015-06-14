function Z=operate(coeffs,coeffs1)

m=coeffs;
n=coeffs1;
for i=2:4
    for j=2:4
         diference=coeffs1{1,i}{1,j}-coeffs{1,i}{1,j};
         coeffs1{1,i}{1,j}=coeffs{1,i}{1,j}+diference/2;
         diference=0;
    end
end


Z=coeffs1;