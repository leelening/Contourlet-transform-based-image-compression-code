function PW=b2d(tp,num)
PW=0;
j=0;
for i=num:-1:1
PW=PW+pow2(tp(i),j);
j=j+1;
end
return