//
//  Bowling.swift
//  Cricket
//
//  Created by Nileshkumar Mukeshbhai Prajapati on 20/06/19.
//  Copyright © 2019 Saturn. All rights reserved.
//

import Foundation

/*
 "10": "0",
 "5w": "2",
 "4w": "4",
 "SR": "50.8",
 "Econ": "4.97",
 "Ave": "42.17",
 "BBM": "5/32",
 "BBI": "5/32",
 "Wkts": "201",
 "Runs": "8478",
 "Balls": "10230",
 "Inns": "",
 "Mat": "551"
 */

struct BowlingInfo: Codable {
    var ten: String?
    var fiveW: String?
    var fourW: String?
    var strikerate: String?
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
        case fiveW = "5w"
        case fourW = "4w"
        case strikerate = "SR"
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
            try values.encodeIfPresent(fiveW, forKey: .fiveW)
            try values.encodeIfPresent(fourW, forKey: .fourW)
            try values.encodeIfPresent(strikerate, forKey: .strikerate)
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
            print("An error occurred at BowlingInfo encoding due to \(error.localizedDescription)")
            throw error
        }
    }
    
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            ten = try? values.decode(String.self, forKey: .ten)
            fiveW = try? values.decode(String.self, forKey: .fiveW)
            fourW = try? values.decode(String.self, forKey: .fourW)
            strikerate = try? values.decode(String.self, forKey: .strikerate)
            economy = try? values.decode(String.self, forKey: .economy)
            average = try? values.decode(String.self, forKey: .average)
            bbm = try? values.decode(String.self, forKey: .bbm)
            bbi = try? values.decode(String.self, forKey: .bbi)
            wickets = try? values.decode(String.self, forKey: .wickets)
            runs = try? values.decode(String.self, forKey: .runs)
            balls = try? values.decode(String.self, forKey: .balls)
            innings = try? values.decode(String.self, forKey: .innings)
            matches = try? values.decode(String.self, forKey: .matches)
        } catch {
            print("An error occurred at BowlingInfo decoding due to \(error.localizedDescription)")
            throw error
        }
    }
    
    func returnBowlingInfo() -> String {
        //playerDetailVM.objPlayerDetails?.statistics?.bowling?.listA
        let information = """
        \n10: \(String(describing: self.ten ?? "N/A"))
        5w: \(String(describing: self.fiveW ?? "N/A"))
        4w: \(String(describing: self.fourW ?? "N/A"))
        SR: \(String(describing: self.strikerate ?? "N/A"))
        Econ: \(String(describing: self.economy ?? "N/A"))
        Ave: \(String(describing: self.average ?? "N/A"))
        BBM: \(String(describing: self.bbm ?? "N/A"))
        BBI: \(String(describing: self.bbi ?? "N/A"))
        Wkts: \(String(describing: self.wickets ?? "N/A"))
        Runs: \(String(describing: self.runs ?? "N/A"))
        Balls: \(String(describing: self.balls ?? "N/A"))
        Inns: \(String(describing: self.innings ?? "N/A"))
        Mat: \(String(describing: self.matches ?? "N/A"))\n
        """
        return information
    }
}

/*
 listA
 firstClass
 T20Is
 ODIs
 tests
 */

struct Bowling: Codable {
    var listA: BowlingInfo?
    var firstClass: BowlingInfo?
    var t20IS: BowlingInfo?
    var odis: BowlingInfo?
    var tests: BowlingInfo?
    
    private enum CodingKeys: String, CodingKey {
        case listA
        case firstClass
        case t20IS = "T20Is"
        case odis = "ODIs"
        case tests
    }
    
    func encode(to encoder: Encoder) throws {
        var values = encoder.container(keyedBy: CodingKeys.self)
        do {
            try values.encodeIfPresent(listA, forKey: .listA)
            try values.encodeIfPresent(firstClass, forKey: .firstClass)
            try values.encodeIfPresent(t20IS, forKey: .t20IS)
            try values.encodeIfPresent(odis, forKey: .odis)
            try values.encodeIfPresent(tests, forKey: .tests)
        } catch {
            print("An error occurred at Bowling encoding due to \(error.localizedDescription)")
            throw error
        }
    }
    
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            listA = try? values.decode(BowlingInfo.self, forKey: .listA)
            firstClass = try? values.decode(BowlingInfo.self, forKey: .firstClass)
            t20IS = try? values.decode(BowlingInfo.self, forKey: .t20IS)
            odis = try? values.decode(BowlingInfo.self, forKey: .odis)
            tests = try? values.decode(BowlingInfo.self, forKey: .tests)
        } catch {
            print("An error occurred at Bowling decoding due to \(error.localizedDescription)")
            throw error
        }
    }
}
