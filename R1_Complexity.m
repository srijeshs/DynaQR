%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% @file   R1_Complexity.m                                                 %
% @brief  Complexity computation of the Rank 1 QR update                  %
%                                                                         %
% I/O PARAMETERS:                                                         %
% @param[in] colStart  The column no. starting from which,                % 
%                      the new columns were added                         %
%                                                                         %
% @param[in] nRows   Number of rows in the R matrix                       %
% @param[in] nNew    Number of new columns added                          %
% @return    COMPLEXITY structure with fields:                            %
%            COMPS No. of comparisons                                     %
%            MULTS No. of multiplies                                      %
%            ADDS  No. of additions                                       %
%            SQRT  No. of square roots                                    %
%                                                                         %
% @author srijeshs                                                        %
% @date   11/12/2018                                                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function COMPLEXITY = R1_Complexity(colStart,nRows,nNew)

% Print interpretation of inputs
fprintf('\nExisting columns in the R matrix = %d\n',colStart-1);

% Initialization
COMPLEXITY.COMPS = 0;   % No. of comparisions
COMPLEXITY.MULTS = 0;   % No. of multiplies
COMPLEXITY.ADDS  = 0;   % No. of additions
COMPLEXITY.SQRT  = 0;   % No. of square roots
totalNewZeros    = 0;   % No. of new zeros we are going to introduce

% For each new column
for iCol = colStart:colStart+nNew-1
   ZerosToAdd = nRows - iCol;   % No. of zeros we need to introduce in this column
   
   % For each new zero required in this column
   for nZeros = 1:ZerosToAdd 
       
    % Givens Matrix generation start
    COMPLEXITY.COMPS = COMPLEXITY.COMPS+1;
    COMPLEXITY.MULTS = COMPLEXITY.MULTS+4;
    COMPLEXITY.ADDS  = COMPLEXITY.ADDS+1;
    COMPLEXITY.SQRT  = COMPLEXITY.SQRT+1;
    % Givens Matrix generation end

    % MAT_VECT_MULT 2x2 Givens * 2x1 Vectors start 
    nMULTS_MATVEC = (colStart +  nNew - iCol) * 4;
    nADDS_MATVEC  = (colStart +  nNew - iCol) * 2;
    
    COMPLEXITY.MULTS = COMPLEXITY.MULTS + nMULTS_MATVEC;
    COMPLEXITY.ADDS  = COMPLEXITY.ADDS + nADDS_MATVEC;
    % MAT_VECT_MULT 2x2 Givens * 2x1 Vectors end
    
    totalNewZeros = totalNewZeros+1;
    
   end % iCol   
end % nZeros

% Print results
fprintf('A total of %d new columns were added\n%d new zero(s) introduced\n',nNew,totalNewZeros);
fprintf('New R''s dimensions = %dx%d',nRows,colStart+nNew-1);
end % function