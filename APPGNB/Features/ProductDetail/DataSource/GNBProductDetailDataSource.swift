//
//  GNBProductDetailDataSource.swift
//  APPGNB
//
//  Created by Jordi Durán on 05/09/2020.
//  Copyright © 2020 Jordi Duran. All rights reserved.
//

import Moya

enum GNBProductDetailDataSource {
    case rates
}


extension GNBProductDetailDataSource: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://quiet-stone-2094.herokuapp.com")!
    }
    
    var path: String {
        switch self {
        case .rates:
            return "/rates.json"
        }
    }
    
    var method: Method {
        switch self {
        case .rates:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .rates:
            return .requestParameters(parameters: [:], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    public var validationType: ValidationType {
      return .successCodes
    }
    
}
