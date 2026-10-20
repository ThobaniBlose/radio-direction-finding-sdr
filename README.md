# Radio Direction Finding Using a Software Defined Radio Approach

## Project Overview and Motivation

This repository contains the simulation and implementation work for a final-year
Electrical and Computer Engineering research project at the University of Cape
Town.

The project investigates phase-based radio direction finding using a
software-defined radio with limited receiver hardware. Its central challenge is
obtaining phase measurements from five antennas when only two receive channels
are available.

The resulting system uses one antenna as a continuous phase reference and
sequentially measures four additional antennas through an RF switch.

## System Architecture

Five antennas are arranged in a circular array. The reference antenna is
connected continuously to ADALM-Pluto+ RX1, while the remaining four antennas
are connected through an HMC7992 RF switch to RX2.

An STM32 controls the switch, and Julia coordinates the switch states and SDR
acquisition. For each state, RX1 and RX2 are sampled together. The four measured
relative phases form a phase signature that is compared with a calibrated
lookup to estimate the source bearing.

## Repository Structure

| Path | Purpose |
|---|---|
| [`simulations/07_UCA_IQ_Correlation_DOA.ipynb`](simulations/07_UCA_IQ_Correlation_DOA.ipynb) | Main I/Q-level RDF simulation and phase-based direction-estimation investigation. |
| [`archive/Simulations_JULIA/03_Circular_Array_DOA.ipynb`](archive/Simulations_JULIA/03_Circular_Array_DOA.ipynb) | Circular-array investigations, phase matching and antenna element-count comparisons. |
| [`hardware/Hardware_Phase_Calibration.ipynb`](hardware/Hardware_Phase_Calibration.ipynb) | Fixed RF-path phase calibration, array calibration and experimental validation. |
| [`hardware/Switched_Array_RDF_System.ipynb`](hardware/Switched_Array_RDF_System.ipynb) | SDR acquisition, switch coordination, phase processing, bearing estimation and live display. |
| [`hardware/RDF_RF_Switch_Test/Core/Src/main.c`](hardware/RDF_RF_Switch_Test/Core/Src/main.c) | STM32 firmware that physically controls the HMC7992 RF switch. |
| [`archive/Simulations_JULIA/`](archive/Simulations_JULIA/) | Earlier ULA and UCA simulations and supporting investigations. |
| [`matlab/`](matlab/) | Earlier MATLAB array-processing investigations. |

The STM32 firmware controls the physical RF-switch state. The Julia hardware
notebooks send switching commands, acquire the corresponding I/Q samples and
perform the direction-estimation processing.

## Implementation and Results

The project progressed from antenna-geometry and phase-matching simulations to
an I/Q-level model of the implemented switched array. The simulations examine
antenna element count, sequential acquisition, source distance, receiver noise
and multipath under controlled conditions.

The hardware implementation includes four-path STM32 switch control, repeated
relative-phase measurements, fixed RF-path correction and open-space array
calibration at 15-degree azimuth intervals. Circular interpolation is used to
form a calibrated lookup covering integer bearings from 0 to 359 degrees.

Experimental validation measurements are recorded in the calibration notebook.
The live RDF notebook integrates carrier detection, antenna switching, phase
measurement, calibrated bearing estimation and a graphical bearing and spectrum
display.

Simulation findings describe behaviour under the chosen models, while the
experimental results apply only to the tested hardware and measurement
configuration.

## Requirements and Usage

The hardware system uses an ADALM-Pluto+ SDR, a five-antenna circular array, an
HMC7992 RF switch and an STM32L432KC-based controller.

The software workflow uses Julia and Jupyter Notebook, with Python integration
through `pyadi-iio` for Pluto communication. The STM32 firmware is provided as
an STM32CubeIDE project.

The Repository Structure table identifies the main notebooks for simulation,
hardware calibration and live measurements. Hardware notebook connection and
configuration values must be reviewed for the local SDR, serial port and
experimental setup.

## Project Status and Limitations

This project is an implemented research prototype rather than a production-ready
RDF receiver.

- The four switched antenna signals are acquired sequentially, so the source and
  propagation channel must remain stable during a measurement cycle.
- Multipath and environmental changes can distort the measured phase signature.
- Reliable operation depends on RF-path and array calibration.
- The recorded calibration and validation results are specific to the tested
  geometry, cabling, frequency and receiver configuration.
