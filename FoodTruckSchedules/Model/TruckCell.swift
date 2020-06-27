//
//  TruckCell.swift
//  DarinFoodTruck
//
//  Created by Darin Williams on 11/24/19.
//  Copyright © 2019 dwilliams. All rights reserved.
//  View Shared between controllers to eliminate duplicate coding
//

import Foundation
import UIKit

class TruckCell: UITableViewCell {

    @IBOutlet weak var foodTruck: UILabel!
    @IBOutlet weak var locationOfTruck: UILabel!
    
    @IBOutlet weak var menuFood: UILabel!
    @IBOutlet weak var hoursOperation: UILabel!
    
}
