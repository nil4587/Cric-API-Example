//
//  Structures.swift
//  Cricket
//
//  Created by Nileshkumar Mukeshbhai Prajapati on 19/06/19.
//  Copyright © 2019 Saturn. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ================================
// MARK: Appliation Informations
// MARK: ================================

struct AppInfo {
    
    /// A parameter which returns Application Title
    static var title: String {
        if let infoDict = Bundle.main.infoDictionary, let title = infoDict["CFBundleDisplayName"] as? String {
            return title
        } else {
            return "Cricket"
        }
    }
    
    /// A parameter which returns Application version
    static var appversion: String {
        if let infoDict = Bundle.main.infoDictionary, let version = infoDict["CFBundleShortVersionString"] as? String {
            return version
        } else {
            return "1.0"
        }
    }
    
    /// A parameter which returns Build version
    static var buildversion: String {
        if let infoDict = Bundle.main.infoDictionary, let version = infoDict["CFBundleVersion"] as? String {
            return version
        } else {
            return "1.0"
        }
    }
    
    /// A parameter which returns Application Delegate
    static var appDelegate: AppDelegate? {return UIApplication.shared.delegate as? AppDelegate}

}

// MARK: - ================================
// MARK: Web-service informations
// MARK: ================================

struct WebService {
    //https://cricapi.com/api/playerFinder?apikey=AVuCBWL7f6bYQNjorItaVxFNdr92&name=Tend
    static let webapi_key = "AVuCBWL7f6bYQNjorItaVxFNdr92"
    static let webapi_url = "https://cricapi.com/api"
    
    /// A structure which keeps web-service request's keys
    struct WebServiceRequestHeaderKey {
        static let HTTPMTDGET_KEY = "GET"
        static let HTTPMTDPOST_KEY = "POST"
        static let SOAPCONTYPE_KEY = "Content-Type"
        static let SOAPACCEPT_KEY = "Accept"
        
        //-- webservice request/response content type
        static let JSONCONTNT_TYPE = "application/json;charset=UTF-8"
    }
}

// MARK: - ================================
// MARK: Other application constants
// MARK: ================================

struct Constants {
    // Keys used within the application
    struct AppKeys {
        static let api_key_title = "apikey"
        
        // Player details section
        static let biography = "Biography :"
        static let bowling_stats = "Bowling Statistics :"
        static let bating_stats = "Batting Statistics :"
        
        // Player Bowling & Batting Info Title Keys
        static let listA = "ListA :"
        static let first_class = "First Class :"
        static let t20s = "T20s :"
        static let odis = "ODIs :"
        static let test = "Tests :"
        
        // Player biography keys
        static let fullname = "Full Name :"
        static let born = "Born :"
        static let age = "Age :"
        static let country = "Country :"
        static let role = "Role :"
        static let battingstyle = "Batting Style :"
        static let bowlingstyle = "Bowling Style :"
        static let majorteams = "Major Teams:"
        static let profile = "Profile :"
    }
    
    // App Views identity keyname
    struct AppViewKeys {
        static let playerdetailview_key = "PlayerDetailsView"
        static let playerlistview_key = "PlayerListView"
    }
    
    // Segues indentifier used in application
    struct AppSegues {
        static let frmplayerlisttodetail = "@frmplayerlisttodetails"
    }
}
