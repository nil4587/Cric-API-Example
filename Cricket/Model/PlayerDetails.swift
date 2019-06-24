//
//  PlayerDetails.swift
//  Cricket
//
//  Created by Nileshkumar Mukeshbhai Prajapati on 20/06/19.
//  Copyright © 2019 Saturn. All rights reserved.
//

import Foundation

// MARK: - ================================
// MARK: Player statistics
// MARK: ================================

protocol PlayerStatisticsProtocol {
    func bowlingStatistics() -> [[String: String]]
    func battingStatistics() -> [[String: String]]
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
            #if DEBUG
            print("An error occurred at Player decoding due to \(error.localizedDescription)")
            #endif
            throw error
        }
    }
    
    func bowlingStatistics() -> [[String: String]] {
        var arrBowling: [[String: String]] = []
        arrBowling.append(["listA".localised(): self.bowling?.listA?.bowlingInformations() ?? "N/A"])
        arrBowling.append(["first_class".localised(): self.bowling?.firstClass?.bowlingInformations() ?? "N/A"])
        arrBowling.append(["t20s".localised(): self.bowling?.t20IS?.bowlingInformations() ?? "N/A"])
        arrBowling.append(["odis".localised(): self.bowling?.ODIs?.bowlingInformations() ?? "N/A"])
        arrBowling.append(["tests".localised(): self.bowling?.tests?.bowlingInformations() ?? "N/A"])
        return arrBowling
    }
    
    func battingStatistics() -> [[String: String]] {
        var arrBatting: [[String: String]] = []
        arrBatting.append(["listA".localised(): self.batting?.listA?.battingInformations() ?? "N/A"])
        arrBatting.append(["first_class".localised(): self.batting?.firstClass?.battingInformations() ?? "N/A"])
        arrBatting.append(["t20s".localised(): self.batting?.t20IS?.battingInformations() ?? "N/A"])
        arrBatting.append(["odis".localised(): self.batting?.ODIs?.battingInformations() ?? "N/A"])
        arrBatting.append(["tests".localised(): self.batting?.tests?.battingInformations() ?? "N/A"])
        return arrBatting
    }
}

// MARK: - ================================
// MARK: Player details
// MARK: ================================

protocol PlayerDetailProtocol {
    func playerInformations() -> [[String: String]]
}

struct PlayerDetails: Codable, PlayerDetailProtocol {
    var playerId: NSNumber?
    var profile: String?
    var imageURL: String?
    var battingStyle: String?
    var bowlingStyle: String?
    var majorTeams: String?
    var age: String?
    var born: String?
    var fullName: String?
    var shortName: String?
    var country: String?
    var role: String?
    var statistics: PlayerStatistics?
    
    private enum CodingKeys: String, CodingKey {
        case playerId = "pid"
        case profile
        case imageURL = "imageURL"
        case battingStyle
        case bowlingStyle
        case majorTeams
        case age = "currentAge"
        case born
        case fullName = "fullName"
        case shortName = "name"
        case country
        case role = "playingRole"
        case statistics = "data"
    }
    
    func encode(to encoder: Encoder) throws {
        var values = encoder.container(keyedBy: CodingKeys.self)
        do {
            try values.encodeIfPresent(playerId?.intValue, forKey: .playerId)
            try values.encodeIfPresent(profile, forKey: .profile)
            try values.encodeIfPresent(imageURL, forKey: .imageURL)
            try values.encodeIfPresent(battingStyle, forKey: .battingStyle)
            try values.encodeIfPresent(bowlingStyle, forKey: .bowlingStyle)
            try values.encodeIfPresent(majorTeams, forKey: .majorTeams)
            try values.encodeIfPresent(age, forKey: .age)
            try values.encodeIfPresent(born, forKey: .born)
            try values.encodeIfPresent(fullName, forKey: .fullName)
            try values.encodeIfPresent(shortName, forKey: .shortName)
            try values.encodeIfPresent(country, forKey: .country)
            try values.encodeIfPresent(role, forKey: .role)
            try values.encodeIfPresent(statistics, forKey: .statistics)
        } catch {
            #if DEBUG
            print("An error occurred at Player Details encoding due to \(error.localizedDescription)")
            #endif
            throw error
        }
    }
    
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            let tmpPlayerId = try? values.decode(Int.self, forKey: .playerId)
            playerId = NSNumber(value: tmpPlayerId ?? 0)
            
            profile = try? values.decode(String.self, forKey: .profile).trimmedString
            imageURL = try? values.decode(String.self, forKey: .imageURL).trimmedString
            battingStyle = try? values.decode(String.self, forKey: .battingStyle).trimmedString
            bowlingStyle = try? values.decode(String.self, forKey: .bowlingStyle).trimmedString
            majorTeams = try? values.decode(String.self, forKey: .majorTeams).trimmedString
            age = try? values.decode(String.self, forKey: .age).trimmedString
            born = try? values.decode(String.self, forKey: .born).trimmedString
            fullName = try? values.decode(String.self, forKey: .fullName).trimmedString
            shortName = try? values.decode(String.self, forKey: .shortName).trimmedString
            country = try? values.decode(String.self, forKey: .country).trimmedString
            role = try? values.decode(String.self, forKey: .role).trimmedString
            statistics = try? values.decode(PlayerStatistics.self, forKey: .statistics)
        } catch {
            #if DEBUG
            print("An error occurred at Player Details decoding due to \(error.localizedDescription)")
            #endif
            throw error
        }
    }
    
    func playerInformations() -> [[String: String]] {
        var arrProfile: [[String: String]] = []
        arrProfile.append(["fullname".localised(): fullName ?? "N/A"])
        arrProfile.append(["born".localised(): born ?? "N/A"])
        arrProfile.append(["age".localised(): age ?? "N/A"])
        arrProfile.append(["country".localised(): country ?? "N/A"])
        arrProfile.append(["role".localised(): role ?? "N/A"])
        arrProfile.append(["bowlingstyle".localised(): bowlingStyle ?? "N/A"])
        arrProfile.append(["battingstyle".localised(): battingStyle ?? "N/A"])
        arrProfile.append(["majorteams".localised(): majorTeams ?? "N/A"])
        arrProfile.append(["profile".localised(): profile ?? "N/A"])
        return arrProfile
    }
}
