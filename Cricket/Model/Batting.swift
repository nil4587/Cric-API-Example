//
//  Batting.swift
//  Cricket
//
//  Created by Nileshkumar Mukeshbhai Prajapati on 20/06/19.
//  Copyright © 2019 Saturn. All rights reserved.
//

import Foundation

// MARK: - ================================
// MARK: Batting details
// MARK: ================================

protocol BattingInfoProtocol {
    func battingInformations() -> String
}

struct BattingInfo: Codable {
    var fifty: String?
    var hundreds: String?
    var stumpings: String?
    var catches: String?
    var sixers: String?
    var boundary: String?
    var ballsFaced: String?
    var highestScore: String?
    var notOut: String?
    var strikeRate: String?
    var average: String?
    var runs: String?
    var innings: String?
    var matches: String?
    
    private enum CodingKeys: String, CodingKey {
        case fifty = "50"
        case hundreds = "100"
        case stumpings = "St"
        case catches = "Ct"
        case sixers = "6s"
        case boundary = "4s"
        case ballsFaced = "BF"
        case highestScore = "HS"
        case notOut = "NO"
        case strikeRate = "SR"
        case average = "Ave"
        case runs = "Runs"
        case innings = "Inns"
        case matches = "Mat"
    }
    
    func encode(to encoder: Encoder) throws {
        var values = encoder.container(keyedBy: CodingKeys.self)
        do {
            try values.encodeIfPresent(fifty, forKey: .fifty)
            try values.encodeIfPresent(hundreds, forKey: .hundreds)
            try values.encodeIfPresent(stumpings, forKey: .stumpings)
            try values.encodeIfPresent(catches, forKey: .catches)
            try values.encodeIfPresent(sixers, forKey: .sixers)
            try values.encodeIfPresent(boundary, forKey: .boundary)
            try values.encodeIfPresent(strikeRate, forKey: .strikeRate)
            try values.encodeIfPresent(ballsFaced, forKey: .ballsFaced)
            try values.encodeIfPresent(average, forKey: .average)
            try values.encodeIfPresent(highestScore, forKey: .highestScore)
            try values.encodeIfPresent(runs, forKey: .runs)
            try values.encodeIfPresent(notOut, forKey: .notOut)
            try values.encodeIfPresent(innings, forKey: .innings)
            try values.encodeIfPresent(matches, forKey: .matches)
        } catch {
            print("An error occurred at BattingInfo encoding due to \(error.localizedDescription)")
            throw error
        }
    }
    
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            fifty = try? values.decode(String.self, forKey: .fifty).trimmedString
            hundreds = try? values.decode(String.self, forKey: .hundreds).trimmedString
            stumpings = try? values.decode(String.self, forKey: .stumpings).trimmedString
            catches = try? values.decode(String.self, forKey: .catches).trimmedString
            sixers = try? values.decode(String.self, forKey: .sixers).trimmedString
            boundary = try? values.decode(String.self, forKey: .boundary).trimmedString
            strikeRate = try? values.decode(String.self, forKey: .strikeRate).trimmedString
            ballsFaced = try? values.decode(String.self, forKey: .ballsFaced).trimmedString
            average = try? values.decode(String.self, forKey: .average).trimmedString
            highestScore = try? values.decode(String.self, forKey: .highestScore).trimmedString
            runs = try? values.decode(String.self, forKey: .runs).trimmedString
            notOut = try? values.decode(String.self, forKey: .notOut).trimmedString
            innings = try? values.decode(String.self, forKey: .innings).trimmedString
            matches = try? values.decode(String.self, forKey: .matches).trimmedString
        } catch {
            print("An error occurred at BattingInfo decoding due to \(error.localizedDescription)")
            throw error
        }
    }
    
    func battingInformations() -> String {
        let information = """
        \n\("bat_fifty".localised()) : \(String(describing: self.fifty ?? "N/A"))
        \("bat_hundreds".localised()) : \(String(describing: self.hundreds ?? "N/A"))
        \("bat_stumps".localised()) : \(String(describing: self.stumpings ?? "N/A"))
        \("bat_catches".localised()) : \(String(describing: self.catches ?? "N/A"))
        \("bat_sixes".localised()) : \(String(describing: self.sixers ?? "N/A"))
        \("bat_boundary".localised()) : \(String(describing: self.boundary ?? "N/A"))
        \("strike_rate".localised()) : \(String(describing: self.strikeRate ?? "N/A"))
        \("bat_ball_faced".localised()) : \(String(describing: self.ballsFaced ?? "N/A"))
        \("average".localised()) : \(String(describing: self.average ?? "N/A"))
        \("bat_highest_score".localised()) : \(String(describing: self.highestScore ?? "N/A"))
        \("runs".localised()) : \(String(describing: self.runs ?? "N/A"))
        \("bat_not_out".localised()) : \(String(describing: self.notOut ?? "N/A"))
        \("innings".localised()) : \(String(describing: self.innings ?? "N/A"))
        \("matches".localised()) : \(String(describing: self.matches ?? "N/A"))\n
        """
        return information
    }
}

// MARK: - ================================
// MARK: Bowling in different formats
// MARK: ================================

struct Batting: Codable {
    var listA: BattingInfo?
    var firstClass: BattingInfo?
    var t20IS: BattingInfo?
    var ODIs: BattingInfo?
    var tests: BattingInfo?
    
    private enum CodingKeys: String, CodingKey {
        case listA
        case firstClass
        case t20IS = "T20Is"
        case ODIs = "ODIs"
        case tests
    }
    
    func encode(to encoder: Encoder) throws {
        var values = encoder.container(keyedBy: CodingKeys.self)
        do {
            try values.encodeIfPresent(listA, forKey: .listA)
            try values.encodeIfPresent(firstClass, forKey: .firstClass)
            try values.encodeIfPresent(t20IS, forKey: .t20IS)
            try values.encodeIfPresent(ODIs, forKey: .ODIs)
            try values.encodeIfPresent(tests, forKey: .tests)
        } catch {
            print("An error occurred at Batting encoding due to \(error.localizedDescription)")
            throw error
        }
    }
    
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            listA = try? values.decode(BattingInfo.self, forKey: .listA)
            firstClass = try? values.decode(BattingInfo.self, forKey: .firstClass)
            t20IS = try? values.decode(BattingInfo.self, forKey: .t20IS)
            ODIs = try? values.decode(BattingInfo.self, forKey: .ODIs)
            tests = try? values.decode(BattingInfo.self, forKey: .tests)
        } catch {
            print("An error occurred at Bowling decoding due to \(error.localizedDescription)")
            throw error
        }
    }
}
