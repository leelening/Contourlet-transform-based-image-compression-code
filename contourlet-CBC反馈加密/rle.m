function [val,len] = rle(x)
% RLE   Run Length Encoding
%    [VAL,LEN] = RLE(X) encodes the data in vector X into run values, VAL, and
%    run lengths, LEN.
%
%    Example:
% 		>> X = [1 1 1 1 3 3 8 8 8 8 8 8]
%       >> [VAL,LEN] = RLE(X)
%    Returns:
%       X =
%            1     1     1     1     3     3     8     8     8     8     8     8
%       VAL =
%            1     3     8
%       LEN =
%            4     2     6
%
%    See also RLD.

% Steve Hoelzer
% 2003-09-04

% Transpose input vector if necessary
if (size(x,2)==1)
    x = x.';
end

% Error checking
if (size(x,1)~=1)
    error('RLE can only process vectors, not matrices')
end

% Encode
i = [ find(x(1:end-1) ~= x(2:end)), length(x) ];
len = diff([ 0 i ]); % run lengths
val = x(i);          % run values