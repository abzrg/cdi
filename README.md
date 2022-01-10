# CDI

This is a case repository for running Capacitive DeIonization simulations using
OpenFOAM (v8). The companion solver is
[cdiFoam](https://github.com/reverseila/cdifoam)

## Workflow

1. Edit `blockMeshDict` and create mesh
    - `make mesh`
2. Calculate the time step (based on a Courant number) and edit the
   `controlDict`
    - Add the calculation process in the `blockMeshDict` file
3. Adsorption
    - edit:
        - `controlDict` (specify time interval and time step (`deltaT`))
        - `funkySetFieldsDict`
    - `make cl clp reset funk dec`
4. Run:
    - `./Allrun && ./desorp.sh && ./Allrun`
