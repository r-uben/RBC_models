% Get the current value of the PATH variable

[~, result] = system('echo $PATH');

% Here you should set the path where you have located your dynare
% executable.
dynare_path = ':/Applications/Dynare/5.4/dynare++/';
if ~contains(result, dynare_path)
    % Append the path to the dynare++ executable to the PATH variable
    setenv('PATH', [result, dynare_path]);
end

original_dir = pwd;2
cd('mod/')
dynare baseline_RBC
dynare RBC_GK
cd(original_dir)