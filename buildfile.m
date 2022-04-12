function plan = buildfile()
import matlab.buildtool.Task;
plan = buildplan();

% Add a task to run your tests by assigning a task object to the plan with a task action
plan("test") = Task(Actions=@test);

% Add a task to package the contents of the project source folder and declare that it requires the test task
plan("package") = Task(Actions=@package,Dependencies="test");

% Add a task to clean the contents of the build folder and implement its action inline
plan("clean") = Task(Actions=@(~)delete("build/**"));

% Set the default tasks on the plan.
plan.DefaultTasks = "package";
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