function d = shex2dec(h)
%SHEX2DEC Convert hexadecimal string to decimal integer.
%   D = SHEX2DEC(H) interprets the hexadecimal string H and returns in D the
%   equivalent decimal number.  
%  
%   If H is a character array or cell array of strings, each row is interpreted
%   as a hexadecimal string. 
%
%   EXAMPLES:
%       shex2dec('FFFFFF2B') and shex2dec('f2b') both return -213
%
%   See also HEX2DEC, DEC2HEX, HEX2NUM, BIN2DEC, BASE2DEC.
if iscellstr(h), h = char(h); end
if isempty(h), d = []; return, end
% Work in upper case.
h = upper(h);
[m,n]=size(h);
% Right justify strings and form 2-D character array.
if ~isempty(find((h==' ' | h==0),1))
  h = strjust(h);
    % Replace any leading blanks and nulls by 0.
    h(cumsum(h ~= ' ' & h ~= 0,2) == 0) = '0';
  else
    h = reshape(h,m,n);
  end
% Check for out of range values
if any(any(~((h>='0' & h<='9') | (h>='A'&h<='F'))))
   error(message('MATLAB:hex2dec:IllegalHexadecimal'));
end
sixteen = 16;
p = fliplr(cumprod([1 sixteen(ones(1,n-1))]));
p = p(ones(m,1),:);
d = h <= 64; % Numbers
h(d) = h(d) - 48;
d =  h > 64; % Letters
h(d) = h(d) - 55;
d = sum(h.*p,2);
% MOD: Handle negative numbers by substracting the most positive
d(d>(16^n)/2) = d(d>(16^n)/2) - 16^n;