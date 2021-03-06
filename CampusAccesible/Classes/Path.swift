//
//  Path.swift
//  CampusAccesible
//
//  Created by Luis Villarreal on 3/14/18.
//  Copyright © 2018 iOS Moviles. All rights reserved.
//

import UIKit

class Path: NSObject {
    var coord1 : Coordinate
    var coord2 : Coordinate
    var coord1_index : Int
    var coord2_index : Int
    var isAccessible : Bool
    var distance : Double
    init(coord1 : Coordinate, coord2 : Coordinate, coord1_index : Int, coord2_index : Int, isAccessible: Bool) {
        self.coord1 = coord1
        self.coord2 = coord2
        self.coord1_index = coord1_index
        self.coord2_index = coord2_index
        self.isAccessible = isAccessible
        let distX = coord1.lat - coord2.lat
        let distY = coord1.lon - coord2.lon
        self.distance = sqrt((distX * distX) + (distY * distY))
    }
    
    static func loadPathArray(locations: [Coordinate]) -> [Path] {
        var paths = [Path]()
        let pathsPath = Bundle.main.path(forResource: "ListaCaminos", ofType: "plist")
        let pathsNSArray = NSArray(contentsOfFile: pathsPath!)
        for path in pathsNSArray! {
            let castPath = path as! NSDictionary
            paths.append(Path(coord1: locations[castPath.value(forKey: "punto1") as! Int], coord2: locations[castPath.value(forKey: "punto2") as! Int], coord1_index: castPath.value(forKey: "punto1") as! Int, coord2_index: castPath.value(forKey: "punto2") as! Int, isAccessible: castPath.value(forKey: "accesible") as! Bool))
        }
        return paths
    }
}
