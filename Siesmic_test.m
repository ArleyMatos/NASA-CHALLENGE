% Passo 1: Carregar os dados
data = readtable('C:\Users\Arley\Downloads\space_apps_2024_seismic_detection\space_apps_2024_seismic_detection\data\mars\training\data\XB.ELYSE.02.BHV.2022-01-02HR04_evid0006.csv','VariableNamingRule','preserve');
sinal_sismico = data{:, 3};  % Ajuste se o sinal estiver em outra coluna

% Passo 2: Calcular o módulo do sinal
modulo_sinal = abs(sinal_sismico);

% Passo 3: Aplicar a Transformada Wavelet Contínua (CWT)
% Definindo a frequência da wavelet
scale = 1:128;  % Ajuste conforme necessário
[cwt_coef, freq] = cwt(modulo_sinal, scale, 'amor');  % Usando a wavelet 'amor' (Morlet)

% Visualizando a CWT
figure;
imagesc(1:length(modulo_sinal), scale, abs(cwt_coef));
axis xy;
xlabel('Tempo (amostras)');
ylabel('Escala (Frequência)');
title('Transformada Wavelet Contínua (CWT) do Sinal Sismico');
colorbar;

% Passo 4: Aplicar um filtro passa-faixa
fs = 1; % Frequência de amostragem, ajuste conforme necessário
filt_low = 0.1;  % Frequência de corte inferior
filt_high = 0.5; % Frequência de corte superior

% Design do filtro passa-faixa
[b, a] = butter(2, [filt_low, filt_high] / (fs / 2), 'bandpass');

% Filtrando o sinal
sinal_filtrado = filtfilt(b, a, modulo_sinal);

% Passo 5: Visualizar o sinal original e o sinal filtrado
figure;
subplot(2,1,1);
plot(modulo_sinal);
title('Sinal Sismico Modulado');
xlabel('Tempo (amostras)');
ylabel('Amplitude');

subplot(2,1,2);
plot(sinal_filtrado);
title('Sinal Filtrado');
xlabel('Tempo (amostras)');
ylabel('Amplitude');

% Passo 6: Recriar o sinal filtrado
% Aqui, o sinal_filtrado já é o sinal reconstruído após o filtro passa-faixa.
