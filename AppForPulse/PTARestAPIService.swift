//
//  PTARestAPIServise.swift
//  AppForPulse
//
//  Created by Ivashin Dmitry on 3/27/17.
//  Copyright © 2017 Ivashin Dmitry. All rights reserved.
//

import Foundation
import Alamofire

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
        let url = EndPoint.baseUrl.rawValue + EndPoint.defaultUrlSuffix.rawValue
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: nil).responseJSON { (response: DataResponse<Any>) in
            
            switch(response.result) {
            case .success(let value):
                completionHandler(APIResult.success(value))
            case .failure(let error):
                completionHandler(APIResult.failure(error))
            }
        }
    }
    
    func searchRecipesBy(title: String, completionHandler: @escaping (APIResult<Any>) -> Void)
    {
        let url = EndPoint.baseUrl.rawValue + EndPoint.search.rawValue + title
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: nil).responseJSON { (response: DataResponse<Any>) in
            
            switch(response.result) {
            case .success(let value):
                completionHandler(APIResult.success(value))
            case .failure(let error):
                completionHandler(APIResult.failure(error))
            }
        }
    }
}
