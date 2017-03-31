//
//  PTARestAPIServise.swift
//  AppForPulse
//
//  Created by Ivashin Dmitry on 3/27/17.
//  Copyright © 2017 Ivashin Dmitry. All rights reserved.
//

import Foundation
import Alamofire
import PKHUD

class PTARestAPIService {
    
    enum EndPoint: String {
        case baseUrl = "http://www.recipepuppy.com/api/?"
        case defaultUrlSuffix = "i=onions,garlic&q=omelet&p=3"
        case search = "q="
    }
    
    enum JSONKey: String {
        case title = "title"
        case deepLink = "href"
        case ingredients = "ingredients"
        case imageThumbnail = "thumbnail"
    } 
    
    func getDefaultListRecipes(_ completionHandler: @escaping (APIResult<Any>) -> Void)
    {
        HUD.show(.progress)
        
        let url = EndPoint.baseUrl.rawValue + EndPoint.defaultUrlSuffix.rawValue
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: nil).responseJSON { (response: DataResponse<Any>) in
            switch(response.result) {
            case .success(let value):
                HUD.flash(.success, delay: 1.0)
                completionHandler(APIResult.success(value))
            case .failure(let error):
                HUD.flash(.error, delay: 1.0)
                completionHandler(APIResult.failure(error))
            }
        }
    }
    
    func searchRecipesBy(title: String, completionHandler: @escaping (APIResult<Any>) -> Void)
    {
        HUD.show(.progress)
        
        let escapedTitle = title.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        
        let url = EndPoint.baseUrl.rawValue + EndPoint.search.rawValue + escapedTitle!
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: nil).responseJSON { (response: DataResponse<Any>) in
            switch(response.result) {
            case .success(let value):
                HUD.flash(.success, delay: 1.0)
                completionHandler(APIResult.success(value))
            case .failure(let error):
                HUD.flash(.error, delay: 1.0)
                completionHandler(APIResult.failure(error))
            }
        }
    }
}
