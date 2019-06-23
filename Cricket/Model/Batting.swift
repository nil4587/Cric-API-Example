//
//  Batting.swift
//  Cricket
//
//  Created by Nileshkumar Mukeshbhai Prajapati on 20/06/19.
//  Copyright © 2019 Saturn. All rights reserved.
//

import Foundation

/*
 "50": "114",
 "100": "60",
 "St": "0",
 "Ct": "175",
 "6s": "",
 "4s": "",
 "SR": "",
 "BF": "",
 "Ave": "45.54",
 "HS": "200*",
 "Runs": "21999",
 "NO": "55",
 "Inns": "538",
 "Mat": "551"
 */

// MARK: - ================================
// MARK: Batting details
// MARK: ================================

protocol BattingInfoProtocol {
    func returnBattingInfo() -> String
}

struct BattingInfo: Codable {
    var fifty: String?
    var hundreds: String?
    var st: String?
    var ct: String?
    var sixers: String?
    var boundary: String?
    var bf: String?
    var highestrun: String?
    var no: String?
    var sr: String?
    var average: String?
    var runs: String?
    var innings: String?
    var matches: String?
    
    private enum CodingKeys: String, CodingKey {
        case fifty = "50"
        case hundreds = "100"
        case st = "St"
        case ct = "Ct"
        case sixers = "6s"
        case boundary = "4s"
        case bf = "BF"
        case highestrun = "HS"
        case no = "NO"
        case sr = "SR"
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
            try values.encodeIfPresent(st, forKey: .st)
            try values.encodeIfPresent(ct, forKey: .ct)
            try values.encodeIfPresent(sixers, forKey: .sixers)
            try values.encodeIfPresent(boundary, forKey: .boundary)
            try values.encodeIfPresent(sr, forKey: .sr)
            try values.encodeIfPresent(bf, forKey: .bf)
            try values.encodeIfPresent(average, forKey: .average)
            try values.encodeIfPresent(highestrun, forKey: .highestrun)
            try values.encodeIfPresent(runs, forKey: .runs)
            try values.encodeIfPresent(no, forKey: .no)
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
            fifty = try? values.decode(String.self, forKey: .fifty)
            hundreds = try? values.decode(String.self, forKey: .hundreds)
            st = try? values.decode(String.self, forKey: .st)
            ct = try? values.decode(String.self, forKey: .ct)
            sixers = try? values.decode(String.self, forKey: .sixers)
            boundary = try? values.decode(String.self, forKey: .boundary)
            sr = try? values.decode(String.self, forKey: .sr)
            bf = try? values.decode(String.self, forKey: .bf)
            average = try? values.decode(String.self, forKey: .average)
            highestrun = try? values.decode(String.self, forKey: .highestrun)
            runs = try? values.decode(String.self, forKey: .runs)
            no = try? values.decode(String.self, forKey: .no)
            innings = try? values.decode(String.self, forKey: .innings)
            matches = try? values.decode(String.self, forKey: .matches)
        } catch {
            print("An error occurred at BattingInfo decoding due to \(error.localizedDescription)")
            throw error
        }
    }
    
    func returnBattingInfo() -> String {
        let information = """
        \n50: \(String(describing: self.fifty ?? "N/A"))
        100: \(String(describing: self.hundreds ?? "N/A"))
        St: \(String(describing: self.st ?? "N/A"))
        Ct: \(String(describing: self.ct ?? "N/A"))
        6s: \(String(describing: self.sixers ?? "N/A"))
        4s: \(String(describing: self.boundary ?? "N/A"))
        SR: \(String(describing: self.sr ?? "N/A"))
        BF: \(String(describing: self.bf ?? "N/A"))
        Ave: \(String(describing: self.average ?? "N/A"))
        HS: \(String(describing: self.highestrun ?? "N/A"))
        Runs: \(String(describing: self.runs ?? "N/A"))
        NO: \(String(describing: self.no ?? "N/A"))
        Inns: \(String(describing: self.innings ?? "N/A"))
        Mat: \(String(describing: self.matches ?? "N/A"))\n
        """
        return information
    }
}

// MARK: - ================================
// MARK: Bowling in different formats
// MARK: ================================

/*
 listA
 firstClass
 T20Is
 ODIs
 tests
 */

struct Batting: Codable {
    var listA: BattingInfo?
    var firstClass: BattingInfo?
    var t20IS: BattingInfo?
    var odis: BattingInfo?
    var tests: BattingInfo?
    
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
            odis = try? values.decode(BattingInfo.self, forKey: .odis)
            tests = try? values.decode(BattingInfo.self, forKey: .tests)
        } catch {
            print("An error occurred at Bowling decoding due to \(error.localizedDescription)")
            throw error
        }
    }
}
