%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% @file   givens_rotate.m                                                 %
% @brief  Givens rotation on a 2x1 vector by a 2x2 rotation matrix        %
%         Result rotated vector is a 2x1 vector with rotated(2) = 0       %
% @author srijeshs                                                        %
% @date   11/12/2018                                                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Givens_Mat = givens_rotate(vector)
% Let vector = | A |
%              | B | 2x1
A = vector(1);
B = vector(2);

% Obtain the Givens rotation matrix = [Cos , Sin ; -Sin , Cos]
if(B ~= 0)
    if(abs(B) > abs(A))
        A_by_B = -A/B;
        hypot  = 1/sqrt(1 + (A_by_B * A_by_B));
        Cos_theta = hypot * A_by_B;
        Sin_theta = hypot;
    else
        B_by_A = -B/A;
        hypot  = 1/sqrt(1 + (B_by_A * B_by_A)); 
        Sin_theta = hypot * B_by_A;
        Cos_theta = hypot;
    end
else
%     No need to rotate since B == 0. Thus, theta = 0                      
%     Cos_theta = 1; % Cos(0)
%     Sin_theta = 0; % Sin(0)
    Givens_Mat = eye(2);
    return;
end

Givens_Mat = [Cos_theta -Sin_theta; Sin_theta Cos_theta];
end