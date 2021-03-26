/*---------------------------------------------------------------------------*\
  =========                 |
  \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox
   \\    /   O peration     | Website:  https://openfoam.org
    \\  /    A nd           | Copyright (C) YEAR OpenFOAM Foundation
     \\/     M anipulation  |
-------------------------------------------------------------------------------
License
    This file is part of OpenFOAM.

    OpenFOAM is free software: you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    OpenFOAM is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
    FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
    for more details.

    You should have received a copy of the GNU General Public License
    along with OpenFOAM.  If not, see <http://www.gnu.org/licenses/>.

\*---------------------------------------------------------------------------*/

#include "fixedValueFvPatchFieldTemplate.H"
#include "addToRunTimeSelectionTable.H"
#include "fvPatchFieldMapper.H"
#include "volFields.H"
#include "surfaceFields.H"
#include "unitConversion.H"
//{{{ begin codeInclude

//}}} end codeInclude


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

namespace Foam
{

// * * * * * * * * * * * * * * * Local Functions * * * * * * * * * * * * * * //

//{{{ begin localCode

//}}} end localCode


// * * * * * * * * * * * * * * * Global Functions  * * * * * * * * * * * * * //

extern "C"
{
    // dynamicCode:
    // SHA1 = 65cdc9579e34e16760566688813db668fb2b401e
    //
    // unique function name that can be checked if the correct library version
    // has been loaded
    void fullyDeveloped_65cdc9579e34e16760566688813db668fb2b401e(bool load)
    {
        if (load)
        {
            // code that can be explicitly executed after loading
        }
        else
        {
            // code that can be explicitly executed before unloading
        }
    }
}

// * * * * * * * * * * * * * * Static Data Members * * * * * * * * * * * * * //

makeRemovablePatchTypeField
(
    fvPatchVectorField,
    fullyDevelopedFixedValueFvPatchVectorField
);


const char* const fullyDevelopedFixedValueFvPatchVectorField::SHA1sum =
    "65cdc9579e34e16760566688813db668fb2b401e";


// * * * * * * * * * * * * * * * * Constructors  * * * * * * * * * * * * * * //

fullyDevelopedFixedValueFvPatchVectorField::
fullyDevelopedFixedValueFvPatchVectorField
(
    const fvPatch& p,
    const DimensionedField<vector, volMesh>& iF
)
:
    fixedValueFvPatchField<vector>(p, iF)
{
    if (false)
    {
        Info<<"construct fullyDeveloped sha1: 65cdc9579e34e16760566688813db668fb2b401e"
            " from patch/DimensionedField\n";
    }
}


fullyDevelopedFixedValueFvPatchVectorField::
fullyDevelopedFixedValueFvPatchVectorField
(
    const fullyDevelopedFixedValueFvPatchVectorField& ptf,
    const fvPatch& p,
    const DimensionedField<vector, volMesh>& iF,
    const fvPatchFieldMapper& mapper
)
:
    fixedValueFvPatchField<vector>(ptf, p, iF, mapper)
{
    if (false)
    {
        Info<<"construct fullyDeveloped sha1: 65cdc9579e34e16760566688813db668fb2b401e"
            " from patch/DimensionedField/mapper\n";
    }
}


fullyDevelopedFixedValueFvPatchVectorField::
fullyDevelopedFixedValueFvPatchVectorField
(
    const fvPatch& p,
    const DimensionedField<vector, volMesh>& iF,
    const dictionary& dict
)
:
    fixedValueFvPatchField<vector>(p, iF, dict)
{
    if (false)
    {
        Info<<"construct fullyDeveloped sha1: 65cdc9579e34e16760566688813db668fb2b401e"
            " from patch/dictionary\n";
    }
}


fullyDevelopedFixedValueFvPatchVectorField::
fullyDevelopedFixedValueFvPatchVectorField
(
    const fullyDevelopedFixedValueFvPatchVectorField& ptf
)
:
    fixedValueFvPatchField<vector>(ptf)
{
    if (false)
    {
        Info<<"construct fullyDeveloped sha1: 65cdc9579e34e16760566688813db668fb2b401e"
            " as copy\n";
    }
}


fullyDevelopedFixedValueFvPatchVectorField::
fullyDevelopedFixedValueFvPatchVectorField
(
    const fullyDevelopedFixedValueFvPatchVectorField& ptf,
    const DimensionedField<vector, volMesh>& iF
)
:
    fixedValueFvPatchField<vector>(ptf, iF)
{
    if (false)
    {
        Info<<"construct fullyDeveloped sha1: 65cdc9579e34e16760566688813db668fb2b401e "
            "as copy/DimensionedField\n";
    }
}


// * * * * * * * * * * * * * * * * Destructor  * * * * * * * * * * * * * * * //

fullyDevelopedFixedValueFvPatchVectorField::
~fullyDevelopedFixedValueFvPatchVectorField()
{
    if (false)
    {
        Info<<"destroy fullyDeveloped sha1: 65cdc9579e34e16760566688813db668fb2b401e\n";
    }
}


// * * * * * * * * * * * * * * * Member Functions  * * * * * * * * * * * * * //

void fullyDevelopedFixedValueFvPatchVectorField::updateCoeffs()
{
    if (this->updated())
    {
        return;
    }

    if (false)
    {
        Info<<"updateCoeffs fullyDeveloped sha1: 65cdc9579e34e16760566688813db668fb2b401e\n";
    }

//{{{ begin code
    #line 31 "/home/ali/OpenFOAM/ali-7/run/cdi/0/U.boundaryField.inlet"
// Define average velocity
            const scalar U_avg = 1;
            // Define height of the channel
            const scalar h = 2;
            // Define unit direction vector
            const vector n (1, 0, 0);
            const vector y (0, 1, 0);

            // Calculate boundary parch center
            const vector ctr (0, 0, 0);

            // Read boundary patch face centre coordinates
            const vectorField& Cf = this->patch().Cf();
            
            const scalarField coord = (((Cf - ctr) & y) / h);

            operator == (n * 1.5 * U_avg * (1 - sqr(coord)));
//}}} end code

    this->fixedValueFvPatchField<vector>::updateCoeffs();
}


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

} // End namespace Foam

// ************************************************************************* //

