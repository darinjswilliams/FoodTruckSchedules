//
//  FoodTruckApi.swift
//  DarinFoodTruck
//
//  Created by Darin Williams on 11/24/19.
//  Copyright © 2019 dwilliams. All rights reserved.
//
//  Client Api to consume Service

import Foundation
import UIKit


class FoodTruckApi {
    

class func processTrucks(completionHandler: @escaping ([FoodTruck]?, Error?)-> Void){
   
    taskForGETRequest(url: buildURL()) {(response, error) in
        guard let response = response else {
            print("requestforfood truck: Failed")
            DispatchQueue.main.async {
                completionHandler(nil, error)
            }
            return
        }
        DispatchQueue.main.async {
            completionHandler(response, error)
        }
    }
}


    fileprivate static func getHeaders(_ request: inout URLRequest) {
        request.httpMethod = AuthenticationUtils.headerGet
        request.addValue(AuthenticationUtils.headerJsonFormat, forHTTPHeaderField: AuthenticationUtils.headerContentType)
        request.addValue(AuthenticationUtils.securityToken, forHTTPHeaderField: AuthenticationUtils.headerToken)
    }
    
    class func taskForGETRequest(url: URL, completionHandler: @escaping ([FoodTruck]?, Error?) -> Void) -> URLSessionDataTask {
    
    var request = URLRequest(url: url)
    
    getHeaders(&request)
    
    
    let downloadTask = URLSession.shared.dataTask(with: request) {
        (data, response, error) in
        // guard there is data
    

        guard let data = data else {
            // TODO: CompleteHandler can return error
            DispatchQueue.main.async {
                completionHandler(nil, error)
            }
            return
        }
        
          
          let jsonDecoder = JSONDecoder()
        do {
            let result = try? jsonDecoder.decode([FoodTruck].self, from: data)
            
            DispatchQueue.main.async {
                completionHandler(result, nil)
            }
            
        } catch {
            DispatchQueue.main.async {
                completionHandler(nil,error)
            }
        }
    }
    
    downloadTask.resume()
    
    return downloadTask
 }
    
   class func getDayOfTheWeek() -> String {
          
          let date = Date()
          let dateFormatter = DateFormatter()

          dateFormatter.dateFormat = "EEEE"
          let dayOfTheWeekString = dateFormatter.string(from: date)
          
          return dayOfTheWeekString
          
          
      }
      
    class  func getCurrentMilitaryTime() ->String{
          
          let date = Date()
          let dateFormatter = DateFormatter()
          
          //Get time in 12 hour format
          dateFormatter.dateFormat = "hh:mm a"
          let standardTimeFormat: String = dateFormatter.string(from: date)
        
          //Convert to Military format
          let twentyFourHourTime = dateFormatter.date(from: standardTimeFormat)
          dateFormatter.dateFormat = "HH:00"

          let militaryTime =  dateFormatter.string(from: twentyFourHourTime!)
          return militaryTime
      }
    
    class  func getStandardTime() ->String{
            
            let date = Date()
            let dateFormatter = DateFormatter()
            
            //Get time in 12 hour format
            dateFormatter.dateFormat = "ha"
            let standardTimeFormat: String = dateFormatter.string(from: date)
          
            return standardTimeFormat
        }
    
    class func buildURL() -> URL {
            let dayOfWeek = self.getDayOfTheWeek()
            let timeOfDay = self.getCurrentMilitaryTime()
            
            var endComp = URLComponents()
            endComp.scheme=AuthenticationUtils.apiScheme
            endComp.host=AuthenticationUtils.apiHost
            endComp.path=AuthenticationUtils.apiPath
            
            endComp.queryItems = [
                URLQueryItem(name: AuthenticationUtils.apiQueryItemWhereClause, value: "starts_with(dayofweekstr,'"+dayOfWeek+"')"),
                URLQueryItem(name: AuthenticationUtils.apiQueryItemStart24Name, value:  timeOfDay ),
                URLQueryItem(name: AuthenticationUtils.apiQueryItemApplicant, value: "applicant")
            ]
            
            var urlEndPoint = endComp.url?.absoluteString

            var myNewEsc = urlEndPoint!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
            var myNewURL = URL(string: myNewEsc!)!
        
        
            return myNewURL
            
    }
}
