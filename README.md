# Simulink Model of a Power Plant

This repository contains a Simulink model of a simplified power plant system. The model simulates the control of steam generation and delivery to a turbine using both PID and MPC control strategies. The repository includes:

- Multiple versions of the plant model (`.slx` files)
- Scripts to initialize and prepare simulations (`.m` files)

## 🔧 Inputs

- Fuel-air mixture supply signal 
- Governor Valve opening 

## 📤 Outputs

- `ms`: Mass flow of superheated steam to the turbine (`[kg/s]`)
- `PD`: Saturated steam pressure in the boiler

---

## 📁 Repository Structure
/models
│
├── MPC_control.slx # Model with MPC control loop
├── PID_control.slx # Model with PID control loop
├── default_model.slx # defualut model
├── linearized_and_discretized.slx # linearized and discretized model

/scripts
│
├── discrete_input.m # Input for dis. model
├── input.m # # Input for default model
├── linearized input.m # Input for lin. model
