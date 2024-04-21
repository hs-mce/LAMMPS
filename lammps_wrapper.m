% system(['conda activate lammps-env']);
clear all; clc;

A = 2.591061; d = 4.076980; rend=5;
input_array = [A d rend];
pert = 1.0e-2;

original_fs(A, d, rend);
system(['lmp -in in.elastic']);
post_process_script;

% saving the values without perturbation
KE_0 = KE;
PE_0 = PE;

KE_pert = zeros(length(input_array), length(KE));
PE_pert = zeros(length(input_array), length(PE));

for i = 1:length(input_array)

    perturbation_of_param = pert*input_array(i);                       
    input_array(i) = input_array(i) + perturbation_of_param;
    
    % updating params
    A = input_array(1);
    d = input_array(2);
    rend = input_array(3);

    % computing the new KE, PE
    original_fs(A, d, rend);
    system(['lmp -in in.elastic']);
    post_process_script;

    % gettin derivative
    KE_pert(i, :) = (KE - KE_0)/(perturbation_of_param);
    PE_pert(i, :) = (PE - PE_0)/(perturbation_of_param);

    input_array(i) = input_array(i) - perturbation_of_param;

end