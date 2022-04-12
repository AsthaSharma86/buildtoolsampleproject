function plan = buildfile()
import matlab.buildtool.Task;
plan = buildplan();

% Add a task to run your tests by assigning a task object to the plan with a task action
plan("test") = Task(Actions=@test,Dependencies="compile");

% Add a compile task to copile mex file
plan("compile") = Task(Actions=@compile);

% Set the default tasks on the plan.
plan.DefaultTasks = "test";
end
 
% Implement the test task action as a local function in the build file
function test(~)
results = runtests("tests",OutputDetail=1);
assertSuccess(results);
end

% Implement the task to compile the mex file
function compile(~)
mex mex\yprime.c
end