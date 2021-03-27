// Alan Brant 2021

$fn=200;

// number of models to hold
models = 5;

// base size of model
modelBaseSize = 32;

// base size 
extraBaseTolerance = 0.5;

baseSize = modelBaseSize + extraBaseTolerance;
floorHeight = 1.5;
rimHeight = 1.5;
rimWidth = 2;



// Difference creates cylinder and subtracts a smaller cylinder
// to create hole to hold model base.
difference(){
    // Create cylinders slightly bigger than model base.
    // Loop through number of models in row.
    for(i = [0:models-1]) {
        translate([i * (baseSize + rimWidth) - i * rimWidth, 0, 0]) {
            // base cylinder
            cylinder(h=rimHeight+floorHeight, d=baseSize + rimWidth);
        }
    }
    
    // Create cylinders the size of the model base to subtract
    // from slightly larger cylinder created above.
    // Loop through number of models in row.
    for(i = [0:models-1]) {
        translate([i * (baseSize + rimWidth) - i * rimWidth, 0, 0]) {
            // move subtraction cylinder up
            translate([0, 0, floorHeight])
            // subtracted cylinder
            cylinder(h=rimHeight+floorHeight, d=baseSize);
        }
    }
}