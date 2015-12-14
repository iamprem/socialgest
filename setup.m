% This is script is to add external libraries to MATLAB path and import
% Dataset into workspace.

clear; clc; close all;
fprintf('Setting up environment...\n');
fprintf('Adding libraries to path...\n');
addpath(genpath('libs'));

fprintf('Importing dataset...\n');
load('data/project1.mat');
load('data/dtw_dist_full.mat');

fprintf('Environment setup SUCCESS\n');