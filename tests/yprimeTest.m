classdef yprimeTest < matlab.unittest.TestCase
    methods(Test)
        % Test methods
        function testInput(testCase)
            verifyError(testCase,@() yprime([8 9 0 7],[0 0],[9 8 7 7]),'MATLAB:yprime:invalidNumInputs');
        end
    end
end