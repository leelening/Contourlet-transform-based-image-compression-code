function CODE = huffman(p)
%HUFFMAN Builds a variable-length Huffman code for a synbol source.
%   CODE = HUFFMAN(P) returns a Huffman code as binary string in
%   cell array CODE for input symbol probability vector P.
%   Each word in CODE corresponds to a symbol whose probobility is
%   at the corresponding index of P.
%
%   based on huffman5 by Sean Danaher

%Check the input arguments for reasonableness
error(nargchk(1,1,nargin));
if (ndims(p) ~= 2 ) | (min(size(p)) > 1) | ~isreal(p) | ~isnumeric(p)
    error('P must be a real numeric vector.');
end

%Global variable surviving all recursions of function 'makecode'
global CODE
CODE = cell(length(p),1);       %init the global cell array

if length(p) > 1
    p = p/sum(p);
    s = reduce(p);
    makecode(s, []);
else
    CODE = {'1'};
end;

