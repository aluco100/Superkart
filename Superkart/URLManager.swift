//
//  URLManager.swift
//  Superkart
//
//  Created by Alfredo Luco on 10-06-17.
//  Copyright © 2017 aluco. All rights reserved.
//

import Foundation
import RealmSwift
import Alamofire

class URLsManager: NSObject {
    
    //MARK: - Router
    
    enum Router: URLRequestConvertible {
        
        //set request constants
        case getItems(parameters: Parameters?)
        case getItem(parameters: Parameters?)
        
        //base URL
        
        static var baseURL: String{
            return "http://superkart.esy.es/"
            
        }
        
        //Method
        var method: HTTPMethod{
            switch self {
            case .getItems:
                return .get
            case .getItem:
                return .get
            }
        }
        
        //Path
        var path: String{
            
            switch self {
            case .getItems(_):
                return "getItems.php"
            case .getItem(_):
                return "getItem.php"
            }
            
        }
        
        //URL Request
        
        func asURLRequest() throws -> URLRequest {
            let url = try Router.baseURL.asURL()
            
            var urlRequest = URLRequest(url: url.appendingPathComponent(path))
            urlRequest.httpMethod = method.rawValue
            
            switch self {
            case .getItems(let parameters):
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
                break
            case .getItem(let parameters):
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
                break
            }
            return urlRequest
            
        }
        
        
    }
    
}
