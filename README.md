# Radio Direction Finding with Software-Defined Radio

This project investigates azimuth estimation for a narrowband radio source using a software-defined radio and a uniform circular antenna array.

## Current approach

The current simulations use:

- a six-element uniform circular array;
- an array radius of approximately `0.4λ`;
- an operating frequency near 433 MHz;
- differential phase measurements between neighbouring antennas;
- a precomputed azimuth phase-signature table; and
- wrapped RMSE to select the best matching direction.

The model currently assumes coherent antenna measurements. Maintaining phase coherence in a practical sequential RF-switching implementation remains an open hardware question.

## Repository layout

- `simulations/` contains the current Julia notebooks.
- `archive/Simulations_JULIA/` contains earlier exploratory Julia work, including array geometry, beamforming, Bartlett and MUSIC estimation, spatial aliasing, switching, and multipath experiments.
- `matlab/` contains earlier MATLAB work.
- `Pluto_Julia_PyCall_Test.ipynb` records an early Julia/Python interoperability test.

The active investigation is the effect of input SNR on azimuth-estimation accuracy for the selected array and differential phase-signature estimator.
