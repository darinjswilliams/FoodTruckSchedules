//
//  TruckMapViewController.swift
//  FoodTruckSchedules
//
//  Created by Darin Williams on 11/26/19.
//  Copyright © 2019 dwilliams. All rights reserved.
//

import UIKit
import MapKit

class TruckMapViewController: UIViewController, MKMapViewDelegate, UITableViewDataSource, UITableViewDelegate {


    @IBOutlet weak var mapView: MKMapView!
    
    

    @IBOutlet weak var foodTruckTableView: UITableView!
    
    //holds data for markers on map
    var foodTruckList = [FoodTruck]()
    
    var mapAnnotations = [MKPointAnnotation]()
    
    var foodTruckSelected = [FoodTruck]()
    
    override func viewDidLoad() {
          super.viewDidLoad()
          
          // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "List", style: .plain, target: self, action: #selector(listFoodTrucks))
        
        //hide back bar button item
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        self.navigationItem.title = "Food Trucks"
        
    
        self.mapView.delegate = self
        
        //DispatchQueue so View can get update
        updateOnBackGround {
            self.findFoodTruckCurrentLocation(foodTruckLocation: self.foodTruckList)
        }
        
        //Lets get a random food truck element from the list and set it as the initial truck
        if(foodTruckList.count > 0 ) {
            foodTruckSelected = [foodTruckList[Int(arc4random_uniform(UInt32(foodTruckList.count)))]]
            foodTruckTableView.reloadData()
        }

      }
    
    @objc func listFoodTrucks(){
            if let navigationController = navigationController {
                navigationController.popViewController(animated: true)
            }
        }

}

//
extension TruckMapViewController {
    
    func findFoodTruckCurrentLocation(foodTruckLocation: [FoodTruck]){
          

          for foodTruck in foodTruckLocation {

            
              let truckLatitude: Double =  CLLocationDegrees(foodTruck.location2.coordinates![0])

              let truckLongitude: Double  = CLLocationDegrees(foodTruck.location2.coordinates![1])
 
              let coordinates = CLLocationCoordinate2D(latitude: truckLongitude,
                                                       longitude:  truckLatitude)
            
              let region = MKCoordinateRegion(center: coordinates, latitudinalMeters: 5000, longitudinalMeters: 5000)
    
              mapView.setRegion(region, animated: true)
            
              let annotation = MKPointAnnotation()
              annotation.coordinate = coordinates
              annotation.title = foodTruck.applicant!
            
              mapAnnotations.append(annotation)
    
          }
          
            self.mapView.addAnnotations(mapAnnotations)
      }
    

    
    // Render Marker Annotation and not Pim
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationId) as? MKMarkerAnnotationView
        
        if pinView == nil {
            pinView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: annotationId)
            pinView?.canShowCallout = false
            pinView?.rightCalloutAccessoryView = UIButton(type:.detailDisclosure)
        } else {
            pinView?.annotation = annotation
        }
        return pinView
    }
    
  
    //Get index of annotation from map and set it
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        let annotation = view.annotation
        let index = (self.mapView.annotations as NSArray).index(of: annotation!)
        foodTruckSelected = [foodTruckList[index]]
        self.foodTruckTableView.reloadData()
    
    }
    
}

// Table Operations
extension TruckMapViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodTruckSelected.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "mapTruckViewCell") as? TruckCell else {
            fatalError("Could not dequeue cell")
        }
        

        cell.foodTruck?.text = self.foodTruckSelected[indexPath.row].applicant
        cell.locationOfTruck?.text = self.foodTruckSelected[indexPath.row].location
        cell.hoursOperation?.text = self.foodTruckSelected[indexPath.row].starttime!  + "-" +
            self.foodTruckList[indexPath.row].endtime!
        
        cell.menuFood?.text = self.foodTruckSelected[indexPath.row].optionaltext
      
        return cell
    }
    
    
    
}
