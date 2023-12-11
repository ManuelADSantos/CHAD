clear; clc; close all;

OpenACC = [57.660828, 59.191677, 56.263539, 56.047478, 56.359085, 57.912639, 62.675758, 98.675815, 343.076298, 460.299380];
Sequential = [0.000692, 0.003598, 0.032891, 0.326033, 3.301003, 15.475167, 81.690587, 735.022999, 7253.093165, 10224.700966];


speedup = Sequential./OpenACC;
elementos = [10, 10^2, 10^3, 10^4, 10^5, 10^6, 10^7, 10^8, 10^9, 10^10];

figure; semilogx(elementos, speedup); grid on;
xlabel("Nº Elementos"); ylabel("Speedup");
ylim([-1 26]); xlim([10 10^10]);
