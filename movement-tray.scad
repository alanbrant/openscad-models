// Alan Brant 2021

$fn=200;

// list for number of models per row
models = [5,5];

// base size of model
modelBaseSize = 32;

// base size 
extraBaseTolerance = 0.5;

baseSize = modelBaseSize + extraBaseTolerance;
floorHeight = 1.5;
rimHeight = 1.5;
rimWidth = 2;

echo("rowNumber=", rowNumber);
// Difference creates cylinder and subtracts a smaller cylinder
// to create hole to hold model base.
difference(){
    for(rowNumber = [0:len(models)-1]) {
        // Create cylinders slightly bigger than model base.
        // Loop through number of models in row.
        for(i = [0:models[rowNumber]-1]) {
            // create cylinder for the row
            translate([i * (baseSize + rimWidth) - i * rimWidth, rowNumber*(baseSize), 0]) {
                // base cylinder
                cylinder(h=rimHeight+floorHeight, d=baseSize + rimWidth);
            }
        }
    }
    for(rowNumber = [0:len(models)-1]) {
        // Create cylinders the size of the model base to subtract
        // from slightly larger cylinder created above.
        // Loop through number of models in row.
        for(i = [0:models[rowNumber]-1]) {
            // create the subtraction cylinders for the rows
            translate([i * (baseSize + rimWidth) - i * rimWidth, rowNumber*(baseSize), 0]) {
                // move subtraction cylinder up
                translate([0, 0, floorHeight])
                // subtracted cylinder
                //color("#FF3333");
                cylinder(h=rimHeight+floorHeight, d=baseSize);
            }
        }
    }
}
