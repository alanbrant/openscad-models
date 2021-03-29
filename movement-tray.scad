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
stagger = true;

module wrapped_base_cylinder(diameter) {
    hull() base_cylinder(diameter);
}

module base_cylinder(diameter) {
    radius = diameter / 2;
    for(rowNumber = [0:len(modelMatrix)-1]) {
        // Create cylinders slightly bigger than model base.
        // Loop through number of models in row.
        for(colNumber = [0:len(modelMatrix[rowNumber])-1]) {
            echo(rowNumber= rowNumber);
            if(modelMatrix[rowNumber][colNumber] > 0) {
                // create cylinder for the row
                x_delta = stagger && rowNumber % 2 == 1 ? diameter / 2 : 0;
                y_delta = stagger ? rowNumber * (diameter - sqrt(4 * pow(radius, 2) - pow(radius, 2))) : 0;
                echo(x_delta= x_delta);
                //y_delta = stagger ? diameter / 2 : 0;
                x = colNumber * (baseSize + rimWidth) - colNumber * rimWidth + 20 - x_delta;
                y = rowNumber * (baseSize) - y_delta;
                translate([x, y, 0]) {
                    // base cylinder
                    color("blue") cylinder(h=rimHeight+floorHeight, d=diameter);
                }
            }
        }
    }
}

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
