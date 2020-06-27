//
//  FoodTruckModel.swift
//  DarinFoodTruck
//
//  Created by Darin Williams on 11/24/19.
//  Copyright © 2019 dwilliams. All rights reserved.
//

import Foundation

struct FoodTruckResponse: Codable {
    let foodTrucks: [FoodTruck] 
}

// MARK: - Food Trucks
struct FoodTruck: Codable {
    let dayorder, dayofweekstr, starttime, endtime: String?
    let permit, location, locationdesc, optionaltext: String?
    let locationid, start24, end24, cnn: String?
    let addrDateCreate, addrDateModified, block, lot: String?
    let coldtruck, applicant, x, y: String?
    let latitude, longitude: String?
    let location2: Location2
    
    enum CodingKeys: String, CodingKey {
        case dayorder, dayofweekstr, starttime, endtime, permit, location, locationdesc, optionaltext, locationid, start24, end24, cnn
        case addrDateCreate
        case addrDateModified
        case block, lot, coldtruck, applicant, x, y, latitude, longitude
        case location2 = "location_2"
    }
}

// MARK: - Location of Truck
struct Location2: Codable {
    let type: String?
    let coordinates: [Double]?
}
