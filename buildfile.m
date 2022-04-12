function plan = buildfile()
import matlab.buildtool.Task;
plan = buildplan();

% Add a task to run your tests by assigning a task object to the plan with a task action
plan("test") = Task(Actions=@test,Dependencies="compile");

% Add a task to package the contents of the project source folder and declare that it requires the test task
plan("package") = Task(Actions=@package,Dependencies="test");

plan("compile") = Task(Actions=@compile);

% Set the default tasks on the plan.
plan.DefaultTasks = "test";
end
 
% Implement the test task action as a local function in the build file
function test(~)
results = runtests("tests",OutputDetail=1);
assertSuccess(results);
end

% Implement the package task action as a local function in the build file
function package(~)
zip("tests","*","C:\Users\asthas\OneDrive - MathWorks\Documents\CI\buildtoolsampleproject\tests");
end

% Implement the task to compile the mex file
function compile(~)
mex mex\yprime.c
end