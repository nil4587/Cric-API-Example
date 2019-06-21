//
//  Enumerations.swift
//  Cricket
//
//  Created by Nileshkumar Mukeshbhai Prajapati on 19/06/19.
//  Copyright © 2019 Saturn. All rights reserved.
//

import Foundation

enum APIResponseCode: Int {
    case success = 200
    case servererror = 500
}

enum APIModule: Int8 {
    case PlayerFinder
    case PlayerStatistics
    
    func returnAPIModuleName() -> String {
        switch self {
        case .PlayerFinder:
            return "playerFinder"
        case .PlayerStatistics:
            return "playerStats"
        }
    }
}
