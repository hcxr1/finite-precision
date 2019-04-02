function P=Detmodel(A,x,count)
% P = Output Polynomial model
% A = matrix to be solved
% x = real integer symbolic for error term, where x = [2^-m,2^-m]
% count = counter for error term, start from n^2 + 1

% Created by Rivan
% Last Modified 26/8/2016

%% Initialize parameter
[r, c]=size(A);  
P=0;

%% Calculate determinant
if (r==2)
    P=(A(1,1)*A(2,2)*(x(count))-A(1,2)*A(2,1)*(x(count+1)))*(x(count+2)); %   for 2x2 matrix, directly calculate the determinant
else
    temp_A=A;
    for i=1:c
        a1i=temp_A(1,i);    % save the element of the 1st row and ith column of the temporary matrix
        if a1i~=0
            temp_A(1,:)=[];     % remove the first row to create the reduced matrix
            temp_A(:,i)=[];     % remove the ith column to create the reduced matrix
            Dnew = Detmodel(temp_A,x,count); 
            count = count + 3;
            if (P ~= 0)
                P = (P+((-1)^(1+i))*a1i*Dnew*(x(count)))*(x(count+1)); % recursively reduce the size of matrix using Leibniz formula
                count = count +  2;
            else
                P = a1i*Dnew*(x(count));
                count = count + 1;
            end
                temp_A=A;           % reset elements of temporary matrix to input elements
        end
    end
end 