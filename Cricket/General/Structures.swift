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
    static var appVersion: String {
        if let infoDict = Bundle.main.infoDictionary, let version = infoDict["CFBundleShortVersionString"] as? String {
            return version
        } else {
            return "1.0"
        }
    }
    
    /// A parameter which returns Build version
    static var buildVersion: String {
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
    static let webAPI_Key = "AVuCBWL7f6bYQNjorItaVxFNdr92"
    static let webAPI_URL = "https://cricapi.com/api"
    
    /// A structure which keeps web-service request's keys
    struct WebServiceRequestHeaderKey {
        static let httpMethod_GET_Key = "GET"
        static let httpMethod_POST_Key = "POST"
        static let soapHeader_ContentType_Key = "Content-Type"
        static let soapHeader_Accept_Key = "Accept"
        
        //-- webservice request/response content type
        static let requestResponseContentType = "application/json;charset=UTF-8"
    }
}

// MARK: - ================================
// MARK: Other application constants
// MARK: ================================

struct Constants {
    // Keys used within the application
    struct AppKeys {
        static let webApiKeyTitle = "apikey"
        static let webApiQueue = "WebAPI_Queue"
    }
    
    // App Views identity keyname
    struct AppViewKeys {
        static let playerDetailViewKey = "PlayerDetailsView"
        static let playerListViewKey = "PlayerListView"
        static let mainStoryboardKey = "Main"
    }
    
    // Segues indentifier used in application
    struct AppSegues {
        static let fromPlayerListToDetail = "@frmplayerlisttodetails"
    }
}
