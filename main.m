clear; close all; clc;
%% loading data
source = load_audio('*source*.wav');
noisy = load_audio('*noisy*.wav');
mix = load_audio('mix*.wav');
%% A - infomax ICA
eta = 0.01;
epoch = 30;

input = mix;
result_A = ica(input, eta, epoch);

save_result(result_A,'result_A_clean_')

source_mat = cell2mat(source)';
corr_mat_A = abs(corr(source_mat',result_A'));

%% B 
eta = 0.01;
epoch = 40;

input = noisy(1:3);

result_B = ica(input, eta, epoch);

save_result(result_B,'result_B_3noisy_')

source_mat = cell2mat(source)';
corr_mat_B = abs(corr(source_mat',result_B'));

%% C (i)
input = noisy;

s_eta = 1e-2;       %start learning rate, in the loop the learning rate changes 
n_epochs = 150;     %number of training epochs
output_dim = 3;     %output dimension

s_W = sanger(input,output_dim,s_eta,n_epochs);      %egan vectors from sanger
%% C (ii)
pca_noisy = pca(cell2mat(noisy));
pca_noisy_3 = pca_noisy(:,1:3);

corr_mat_egan_vec = abs(corr(pca_noisy_3,s_W'));
%% C(iii)

reduced_sanger_noisy = cell2mat(noisy)*s_W';

eta = 0.01;
epoch = 40;

input = reduced_sanger_noisy;

result_C = ica(input, eta, epoch);
save_result(result_C,'result_C_noisy_sanger')

source_mat = cell2mat(source)';
corr_mat_C_S = abs(corr(source_mat',result_C'));    %sanger & source

corr_mat_C_A = abs(corr(result_A',result_C'));      %sanger & section-A (mix)
corr_mat_C_B = abs(corr(result_B',result_C'));      %sanger & section-B (noisymix)
