iHoles = 10;
jHoles = 20;

layers = 3;

holeDiameter = 1.5; //mm 
holePadding = 1; 

boltDiameter = 3;
boltPadding = 2;
boltInnerMargin = 5;

materialThickness = 3;


boxWidth = (iHoles * (holePadding+holeDiameter))+holePadding+boltDiameter*2+boltPadding*2+boltInnerMargin*2;

boxHeight = (jHoles * (holePadding+holeDiameter))+holePadding+boltDiameter*2+boltPadding*2+boltInnerMargin*2;


module holeGrid(dimensions) {
    for(i = [0:iHoles-1]) {
        translate([i*(holeDiameter+holePadding),0,0]) {
            for(j = [0:jHoles-1]) {
                translate([0,j*(holeDiameter+holePadding),0]) {
                    if(dimensions == "3D") {
                        translate([0,0,-0.5]) {
                        cylinder(materialThickness+1,holeDiameter/2,holeDiameter/2, $fn=100);
                        }
                    } else if(dimensions == "2D") {
                        circle(holeDiameter/2, $fn=100);
                    }
                }
            }
        }
    }
}


module boltHole(dimensions) {
    if(dimensions == "3D") {
        translate([0,0,-0.5]) {
            cylinder(materialThickness+1, boltDiameter/2,boltDiameter/2, $fn=100);
        }
    }else if(dimensions == "2D") {
        circle(boltDiameter/2, $fn=100);
    }
}


module singlePlate(dimensions) {
    difference() {
        square([boxWidth, boxHeight]);
        translate([boltDiameter+boltPadding+holePadding+holeDiameter/2+boltInnerMargin,
            boltDiameter+boltPadding+holePadding+holeDiameter/2+boltInnerMargin,0]) {
            holeGrid(dimensions);
        }
        
        translate([boltPadding+boltDiameter/2, 
            boltPadding+boltDiameter/2, 0]) {
            boltHole(dimensions);
        }
        translate([boxWidth-(boltPadding+boltDiameter/2), 
            boltPadding+boltDiameter/2, 0]) {
            boltHole(dimensions);
        }
        translate([boxWidth-(boltPadding+boltDiameter/2), 
            boxHeight-(boltPadding+boltDiameter/2), 0]) {
            boltHole(dimensions);
        }
        translate([boltPadding+boltDiameter/2, 
            boxHeight-(boltPadding+boltDiameter/2), 0]) {
            boltHole(dimensions);
        }
    }
}

singlePlate("2D");
