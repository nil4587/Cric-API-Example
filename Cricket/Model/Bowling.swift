//
//  Bowling.swift
//  Cricket
//
//  Created by Nileshkumar Mukeshbhai Prajapati on 20/06/19.
//  Copyright © 2019 Saturn. All rights reserved.
//

import Foundation

// MARK: - ================================
// MARK: Bowling details
// MARK: ================================

protocol BowlingInfoProtocol {
    func bowlingInformations() -> String
}

struct BowlingInfo: Codable, BowlingInfoProtocol {
    var ten: String?
    var fiveWckts: String?
    var fourWckts: String?
    var strikeRate: String?
    var economy: String?
    var average: String?
    var bbm: String?
    var bbi: String?
    var wickets: String?
    var runs: String?
    var balls: String?
    var innings: String?
    var matches: String?
    
    private enum CodingKeys: String, CodingKey {
        case ten = "10"
        case fiveWckts = "5w"
        case fourWckts = "4w"
        case strikeRate = "SR"
        case economy = "Econ"
        case average = "Ave"
        case bbm = "BBM"
        case bbi = "BBI"
        case wickets = "Wkts"
        case runs = "Runs"
        case balls = "Balls"
        case innings = "Inns"
        case matches = "Mat"
    }
    
    func encode(to encoder: Encoder) throws {
        var values = encoder.container(keyedBy: CodingKeys.self)
        do {
            try values.encodeIfPresent(ten, forKey: .ten)
            try values.encodeIfPresent(fiveWckts, forKey: .fiveWckts)
            try values.encodeIfPresent(fourWckts, forKey: .fourWckts)
            try values.encodeIfPresent(strikeRate, forKey: .strikeRate)
            try values.encodeIfPresent(economy, forKey: .economy)
            try values.encodeIfPresent(average, forKey: .average)
            try values.encodeIfPresent(bbm, forKey: .bbm)
            try values.encodeIfPresent(bbi, forKey: .bbi)
            try values.encodeIfPresent(wickets, forKey: .wickets)
            try values.encodeIfPresent(runs, forKey: .runs)
            try values.encodeIfPresent(balls, forKey: .balls)
            try values.encodeIfPresent(innings, forKey: .innings)
            try values.encodeIfPresent(matches, forKey: .matches)
        } catch {
            #if DEBUG
            print("An error occurred at BowlingInfo encoding due to \(error.localizedDescription)")
            #endif
            throw error
        }
    }
    
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            ten = try? values.decode(String.self, forKey: .ten).trimmedString
            fiveWckts = try? values.decode(String.self, forKey: .fiveWckts).trimmedString
            fourWckts = try? values.decode(String.self, forKey: .fourWckts).trimmedString
            strikeRate = try? values.decode(String.self, forKey: .strikeRate).trimmedString
            economy = try? values.decode(String.self, forKey: .economy).trimmedString
            average = try? values.decode(String.self, forKey: .average).trimmedString
            bbm = try? values.decode(String.self, forKey: .bbm).trimmedString
            bbi = try? values.decode(String.self, forKey: .bbi).trimmedString
            wickets = try? values.decode(String.self, forKey: .wickets).trimmedString
            runs = try? values.decode(String.self, forKey: .runs).trimmedString
            balls = try? values.decode(String.self, forKey: .balls).trimmedString
            innings = try? values.decode(String.self, forKey: .innings).trimmedString
            matches = try? values.decode(String.self, forKey: .matches).trimmedString
        } catch {
            #if DEBUG
            print("An error occurred at BowlingInfo decoding due to \(error.localizedDescription)")
            #endif
            throw error
        }
    }
    
    func bowlingInformations() -> String {
        //playerDetailVM.objPlayerDetails?.statistics?.bowling?.listA
        let information = """
        \n\("bwl_tenWckts".localised()) : \(String(describing: self.ten ?? "N/A"))
        \("bwl_fiveWckts".localised()) : \(String(describing: self.fiveWckts ?? "N/A"))
        \("bwl_fourWckts".localised()) : \(String(describing: self.fourWckts ?? "N/A"))
        \("strikeRate".localised()) : \(String(describing: self.strikeRate ?? "N/A"))
        \("bwl_economy".localised()) : \(String(describing: self.economy ?? "N/A"))
        \("averag e".localised()) : \(String(describing: self.average ?? "N/A"))
        \("bwl_bbm".localised()) : \(String(describing: self.bbm ?? "N/A"))
        \("bwl_bbi".localised()) : \(String(describing: self.bbi ?? "N/A"))
        \("bwl_wickets".localised()) : \(String(describing: self.wickets ?? "N/A"))
        \("runs".localised()) : \(String(describing: self.runs ?? "N/A"))
        \("balls".localised()) : \(String(describing: self.balls ?? "N/A"))
        \("innings".localised()) : \(String(describing: self.innings ?? "N/A"))
        \("matches".localised()) : \(String(describing: self.matches ?? "N/A"))\n
        """
        return information
    }
}

// MARK: - ================================
// MARK: Bowling in different formats
// MARK: ================================

struct Bowling: Codable {
    var listA: BowlingInfo?
    var firstClass: BowlingInfo?
    var t20IS: BowlingInfo?
    var ODIs: BowlingInfo?
    var tests: BowlingInfo?
    
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
            #if DEBUG
            print("An error occurred at Bowling encoding due to \(error.localizedDescription)")
            #endif
            throw error
        }
    }
    
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            listA = try? values.decode(BowlingInfo.self, forKey: .listA)
            firstClass = try? values.decode(BowlingInfo.self, forKey: .firstClass)
            t20IS = try? values.decode(BowlingInfo.self, forKey: .t20IS)
            ODIs = try? values.decode(BowlingInfo.self, forKey: .ODIs)
            tests = try? values.decode(BowlingInfo.self, forKey: .tests)
        } catch {
            #if DEBUG
            print("An error occurred at Bowling decoding due to \(error.localizedDescription)")
            #endif
            throw error
        }
    }
}
