// Alan Brant 2021

$fn=100;

// matrix for number of models and position per row.
// 1 for model holder in position and 0 for none.
modelMatrix = [
[1,1,1,1,1],
[1,1,1,1,1]];

// base size of model
modelBaseSize = 32;

// base size 
extraBaseTolerance = 0.5;

baseSize = modelBaseSize + extraBaseTolerance;
floorHeight = 1.5;
rimHeight = 1.5;
rimWidth = 2;

wrap = true;

module wrapped_base_cylinder(diameter) {
    hull() base_cylinder(diameter);
}

module base_cylinder(diameter) {
    for(rowNumber = [0:len(modelMatrix)-1]) {
        // Create cylinders slightly bigger than model base.
        // Loop through number of models in row.
        for(colNumber = [0:len(modelMatrix[rowNumber])-1]) {
            if(modelMatrix[rowNumber][colNumber] > 0) {
                // create cylinder for the row
                x = colNumber * (baseSize + rimWidth) - colNumber * rimWidth;
                y = rowNumber * (baseSize);
                translate([x, y, 0]) {
                    // base cylinder
                    color("blue") cylinder(h=rimHeight+floorHeight, d=diameter);
                }
            }
        }
    }
}

function doHull() = (
    (wrap) ?
        hull()
    : hull()
);

// Difference creates cylinder and subtracts a smaller cylinder
// to create hole to hold model base.
difference(){
    // outer object
    color("blue") 
    if(wrap) {
        wrapped_base_cylinder(baseSize + rimWidth);
    }
    else {
        base_cylinder(baseSize + rimWidth);
    }
    // inner object to subtract
    color("red") translate([0, 0, floorHeight]) base_cylinder(baseSize) ;
}
