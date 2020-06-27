//
//  ViewController+Extensions.swift
//  FoodTruckSchedules
//
//  Created by Darin Williams on 11/27/19.
//  Copyright © 2019 dwilliams. All rights reserved.
//

import Foundation
import UIKit

//Update UI on Background Thread
extension UIViewController {
    func updateOnBackGround(_ updates: @escaping () -> Void) {
        DispatchQueue.main.async {
            updates()
        }
    }
}
