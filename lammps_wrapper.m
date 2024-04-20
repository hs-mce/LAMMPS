% system(['conda activate lammps-env']);
clear all; clc;

original_fs;
system(['lmp -in in.elastic']);

post_process_script;