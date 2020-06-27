//
//  TruckListViewController.swift
//  FoodTruckSchedules
//
//  Created by Darin Williams on 11/26/19.
//  Copyright © 2019 dwilliams. All rights reserved.
//

import UIKit
import CoreData

class TruckListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

   var foodTruckList = [FoodTruck]()

        @IBOutlet weak var truckTblView: UITableView!
        
        override func viewDidLoad() {
            super.viewDidLoad()

            // Do any additional setup after loading the view
            let truck: Truck
            callParseFoodTruckApi()
        }
        
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let trkMapViewCtrl = segue.destination as! TruckMapViewController
        
        trkMapViewCtrl.foodTruckList = self.foodTruckList
        
    }
}

    extension TruckListViewController {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return foodTruckList.count
          }
          
          func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellTruckListing", for: indexPath)  as? TruckCell else {
                fatalError("Could not dequeue cell")
            }
            
            cell.foodTruck.text = self.foodTruckList[indexPath.row].applicant
            cell.hoursOperation.text = (self.foodTruckList[indexPath.row].starttime ?? "") + "-" + (self.foodTruckList[indexPath.row].endtime ?? "")
            cell.locationOfTruck.text = self.foodTruckList[indexPath.row].location
            cell.menuFood.text = self.foodTruckList[indexPath.row].optionaltext
            
            return cell
          }
        
    }

    extension TruckListViewController {
        
        func callParseFoodTruckApi(){
            
            FoodTruckApi.processTrucks(completionHandler: handleGetFoodTruckListing(foodTrucks:error:))
        }
        
        
        func handleGetFoodTruckListing(foodTrucks:[FoodTruck]?, error:Error?) {
            

            guard let foodTrucks = foodTrucks else {
                print("No Data Return")
                return }
            print("Number of Items Return \(foodTrucks.count)")
            
            self.foodTruckList = foodTrucks
            
            self.truckTblView.reloadData()
        }
        
      
    }
