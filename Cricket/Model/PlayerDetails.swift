//
//  PlayerDetails.swift
//  Cricket
//
//  Created by Nileshkumar Mukeshbhai Prajapati on 20/06/19.
//  Copyright © 2019 Saturn. All rights reserved.
//

import Foundation
/*
"pid": 35320,
"profile": "\n\nSachin Tendulkar has been the most complete batsman of his time, the most prolific runmaker of all time, and arguably the biggest cricket icon the game has ever known. His batting was based on the purest principles: perfect balance, economy of movement, precision in stroke-making, and that intangible quality given only to geniuses - anticipation. If he didn't have a signature stroke - the upright, back-foot punch comes close - it's because he was equally proficient at each of the full range of orthodox shots (and plenty of improvised ones as well) and can pull them out at will.  \n\n",
"imageURL": "https://www.cricapi.com/playerpic/35320.jpg",
"battingStyle": "Right-hand bat",
"bowlingStyle": "Right-arm offbreak, Legbreak googly",
"majorTeams": "India,Asia XI,Mumbai,Mumbai Indians,Yorkshire",
"currentAge": "44 years 186 days",
"born": "April 24, 1973, Bombay (now Mumbai), Maharashtra",
"fullName": "Sachin Ramesh Tendulkar",
"name": "Sachin Tendulkar",
"country": "India",
"playingRole": "Top-order batsman",
*/

// MARK: - ================================
// MARK: Player statistics
// MARK: ================================

protocol PlayerStatisticsProtocol {
    func returnBowlingInfo() -> [[String: String]]
    func returnBattingInfo() -> [[String: String]]
}

struct PlayerStatistics: Codable, PlayerStatisticsProtocol {
    var bowling: Bowling?
    var batting: Batting?
    
    private enum CodingKeys: String, CodingKey {
        case bowling = "bowling"
        case batting = "batting"
    }
    
    func encode(to encoder: Encoder) throws {
        var values = encoder.container(keyedBy: CodingKeys.self)
        do {
            try values.encodeIfPresent(bowling, forKey: .bowling)
            try values.encodeIfPresent(batting, forKey: .batting)
        } catch {
            print("An error occurred at Player Statistics encoding due to \(error.localizedDescription)")
            throw error
        }
    }
    
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            bowling = try? values.decode(Bowling.self, forKey: .bowling)
            batting = try? values.decode(Batting.self, forKey: .batting)
        } catch {
            print("An error occurred at Player decoding due to \(error.localizedDescription)")
            throw error
        }
    }
    
    func returnBowlingInfo() -> [[String: String]] {
        var arrBowling: [[String: String]] = []
        arrBowling.append([Constants.AppKeys.listA: self.bowling?.listA?.returnBowlingInfo() ?? "N/A"])
        arrBowling.append([Constants.AppKeys.first_class: self.bowling?.firstClass?.returnBowlingInfo() ?? "N/A"])
        arrBowling.append([Constants.AppKeys.t20s: self.bowling?.t20IS?.returnBowlingInfo() ?? "N/A"])
        arrBowling.append([Constants.AppKeys.odis: self.bowling?.odis?.returnBowlingInfo() ?? "N/A"])
        arrBowling.append([Constants.AppKeys.test: self.bowling?.tests?.returnBowlingInfo() ?? "N/A"])
        return arrBowling
    }
    
    func returnBattingInfo() -> [[String: String]] {
        var arrBatting: [[String: String]] = []
        arrBatting.append([Constants.AppKeys.listA: self.batting?.listA?.returnBattingInfo() ?? "N/A"])
        arrBatting.append([Constants.AppKeys.first_class: self.batting?.firstClass?.returnBattingInfo() ?? "N/A"])
        arrBatting.append([Constants.AppKeys.t20s: self.batting?.t20IS?.returnBattingInfo() ?? "N/A"])
        arrBatting.append([Constants.AppKeys.odis: self.batting?.odis?.returnBattingInfo() ?? "N/A"])
        arrBatting.append([Constants.AppKeys.test: self.batting?.tests?.returnBattingInfo() ?? "N/A"])
        return arrBatting
    }
}

// MARK: - ================================
// MARK: Player details
// MARK: ================================

protocol PlayerDetailProtocol {
    func returnPlayerInfo() -> [[String: String]]
}

struct PlayerDetails: Codable, PlayerDetailProtocol {
    var pid: NSNumber?
    var profile: String?
    var imageurl: String?
    var battingStyle: String?
    var bowlingStyle: String?
    var majorTeams: String?
    var age: String?
    var born: String?
    var fname: String?
    var name: String?
    var country: String?
    var role: String?
    var statistics: PlayerStatistics?
    
    private enum CodingKeys: String, CodingKey {
        case pid
        case profile
        case imageurl = "imageURL"
        case battingStyle
        case bowlingStyle
        case majorTeams
        case age = "currentAge"
        case born
        case fname = "fullName"
        case name
        case country
        case role = "playingRole"
        case statistics = "data"
    }
    
    func encode(to encoder: Encoder) throws {
        var values = encoder.container(keyedBy: CodingKeys.self)
        do {
            try values.encodeIfPresent(pid?.intValue, forKey: .pid)
            try values.encodeIfPresent(profile, forKey: .profile)
            try values.encodeIfPresent(imageurl, forKey: .imageurl)
            try values.encodeIfPresent(battingStyle, forKey: .battingStyle)
            try values.encodeIfPresent(bowlingStyle, forKey: .bowlingStyle)
            try values.encodeIfPresent(majorTeams, forKey: .majorTeams)
            try values.encodeIfPresent(age, forKey: .age)
            try values.encodeIfPresent(born, forKey: .born)
            try values.encodeIfPresent(fname, forKey: .fname)
            try values.encodeIfPresent(name, forKey: .name)
            try values.encodeIfPresent(country, forKey: .country)
            try values.encodeIfPresent(role, forKey: .role)
            try values.encodeIfPresent(statistics, forKey: .statistics)
        } catch {
            print("An error occurred at Player Details encoding due to \(error.localizedDescription)")
            throw error
        }
    }
    
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            let tmppid = try? values.decode(Int.self, forKey: .pid)
            pid = NSNumber(value: tmppid ?? 0)
            
            profile = try? values.decode(String.self, forKey: .profile)
            imageurl = try? values.decode(String.self, forKey: .imageurl)
            battingStyle = try? values.decode(String.self, forKey: .battingStyle)
            bowlingStyle = try? values.decode(String.self, forKey: .bowlingStyle)
            majorTeams = try? values.decode(String.self, forKey: .majorTeams)
            age = try? values.decode(String.self, forKey: .age)
            born = try? values.decode(String.self, forKey: .born)
            fname = try? values.decode(String.self, forKey: .fname)
            name = try? values.decode(String.self, forKey: .name)
            country = try? values.decode(String.self, forKey: .country)
            role = try? values.decode(String.self, forKey: .role)
            statistics = try? values.decode(PlayerStatistics.self, forKey: .statistics)
        } catch {
            print("An error occurred at Player Details decoding due to \(error.localizedDescription)")
            throw error
        }
    }
    
    func returnPlayerInfo() -> [[String: String]] {
        var arrProfile: [[String: String]] = []
        arrProfile.append([Constants.AppKeys.fullname: fname ?? "N/A"])
        arrProfile.append([Constants.AppKeys.born: born ?? "N/A"])
        arrProfile.append([Constants.AppKeys.age: age ?? "N/A"])
        arrProfile.append([Constants.AppKeys.country: country ?? "N/A"])
        arrProfile.append([Constants.AppKeys.role: role ?? "N/A"])
        arrProfile.append([Constants.AppKeys.bowlingstyle: bowlingStyle ?? "N/A"])
        arrProfile.append([Constants.AppKeys.battingstyle: battingStyle ?? "N/A"])
        arrProfile.append([Constants.AppKeys.majorteams: majorTeams ?? "N/A"])
        arrProfile.append([Constants.AppKeys.profile: profile ?? "N/A"])
        return arrProfile
    }
}
