/*--------------------------------*-------*----------------------------------*\
  =========                 |
  \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox
   \\    /   O peration     | Website:  https://openfoam.org
    \\  /    A nd           | Version:  8
     \\/     M anipulation  |
\*---------------------------------------------------------------------------*/

// Vars for creating mesh in blockMeshDict
he 0.68;                        // height of electrode (mm)
hs  0.4;                        // height of spacer (mm)
ht #calc "$hs + $he";           // total height (mm)
U_avg 4.38e-4;                   // Average velocity in x direction
length_inlet_outlet 12.5; //(mm)
length_middle 100; //(mm)

// Number of division in each direction
// -----------------------------------------------------------
no_x_inlet_outlet 450; // <<<<<<<<---------------- CHANGE THIS
// -----------------------------------------------------------

no_x_middle #calc "std::round($no_x_inlet_outlet * $length_middle / $length_inlet_outlet)";
no_y_spacer #calc "std::round($no_x_inlet_outlet * $hs / $length_inlet_outlet)";
no_y_elec #calc "std::round($no_x_inlet_outlet * $he / $length_inlet_outlet)";
no_z 1;

// Vars for calculating deltaT
U_max 8.76e-4;                  // max velocity (m/s)
// ----------------------------------------------------------------------
co 1;                           // Courant number <<<<<--------- AND THIS
// ----------------------------------------------------------------------
ms #calc "$length_inlet_outlet / $no_x_inlet_outlet / 1000";   // mesh size (m)
ts #calc "$co * $ms / $U_max";  // time step (s)

/* // Decomposition */
/* no_subdomain 1; */
/* no_subdomain_x 4; */
/* no_subdomain_y 2; */

// ****************** vi: set ft=foam et sw=4 ts=4 sts=4: ****************** //
