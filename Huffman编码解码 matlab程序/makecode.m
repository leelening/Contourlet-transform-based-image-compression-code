function makecode(sc, codeword)
% Scan the nodes of a Huffman source reduction tree recursively to generate
% the indicated variable length code words.

% Global variable surviving all recursive calls
global CODE
if isa(sc, 'cell')
    makecode(sc{1}, [codeword 0]);
    makecode(sc{2}, [codeword 1]);
else
    CODE{sc} = char('0' + codeword);
end