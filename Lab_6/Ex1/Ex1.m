clear; clc; close all;

table = readtable('file.txt');
matriz = table{:,:};

% 2:481
figure();
mesh(matriz(2:481,1:end));
figure();
surf(matriz(2:481,1:end));