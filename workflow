1. Create mesh
    - make mesh
2. Calculate the time step (based on a courant number)
    - Add the calculation process in the blockMeshDict file
3. Adsorption
    - edit:
        - controlDict (specify time interval)
        - funkySetFieldsDict
    - make cl clp funk_ads dec_ads
4. Desorption
    - edit:
        - controlDict (specify time interval)
        - funkySetFieldsDict
    - make funk_des dec_des
