//
//  Player.swift
//  Cricket
//
//  Created by Nileshkumar Mukeshbhai Prajapati on 19/06/19.
//  Copyright © 2019 Saturn. All rights reserved.
//

import Foundation

// MARK: - ================================
// MARK: An object for Player's informations
// MARK: ================================

struct Player: Codable {
    var fname: String?
    var name: String?
    var pid: NSNumber?
    
    private enum CodingKeys: String, CodingKey {
        case fname = "fullName"
        case name
        case pid
    }
    
    func encode(to encoder: Encoder) throws {
        var values = encoder.container(keyedBy: CodingKeys.self)
        do {
            try values.encodeIfPresent(fname, forKey: .fname)
            try values.encodeIfPresent(name, forKey: .name)
            try values.encodeIfPresent(pid?.intValue, forKey: .pid)
        } catch {
            print("An error occurred at Player encoding due to \(error.localizedDescription)")
            throw error
        }
    }
    
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            fname = try? values.decode(String.self, forKey: .fname)
            name = try? values.decode(String.self, forKey: .name)
            let tmppid = try? values.decode(Int.self, forKey: .pid)
            pid = NSNumber(value: tmppid ?? 0)
        } catch {
            print("An error occurred at Player decoding due to \(error.localizedDescription)")
            throw error
        }
    }
}
