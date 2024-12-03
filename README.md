# ELEC421_FinalProject
UBC ELEC 421 - 2024 - final project repository. Done with a group of 6

In this project, we provided implementations of a naive DFT algorithm as well as Decimation-in-Time (DIT) and Decimation-in-Frequency (DIF) FFT algorithms. 

Please see out source files under `./src/`. To see results, please run main.m script. This script does the following:
* Reads `clean_signal.wav` and `noisy_signal.wav`.
* Runs (1) `naive_dft.m` (2) `dif_fft.m` (3) `dif_fft.m` and the `built-in fft` on both signals
* Plots the magnitude spectrum (+ zoomed in version) of both signals
* Log-plots performance and runtime analysis of all version on signals of sizes 2^5 to 2^14.