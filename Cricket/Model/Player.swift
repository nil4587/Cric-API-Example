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
    var fullName: String?
    var shortName: String?
    var playerId: NSNumber?
    
    private enum CodingKeys: String, CodingKey {
        case fullName = "fullName"
        case shortName = "name"
        case playerId = "pid"
    }
    
    func encode(to encoder: Encoder) throws {
        var values = encoder.container(keyedBy: CodingKeys.self)
        do {
            try values.encodeIfPresent(fullName, forKey: .fullName)
            try values.encodeIfPresent(shortName, forKey: .shortName)
            try values.encodeIfPresent(playerId?.intValue, forKey: .playerId)
        } catch {
            #if DEBUG
            print("An error occurred at Player encoding due to \(error.localizedDescription)")
            #endif
            throw error
        }
    }
    
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            fullName = try? values.decode(String.self, forKey: .fullName)
            shortName = try? values.decode(String.self, forKey: .shortName)
            let tmpPlayerId = try? values.decode(Int.self, forKey: .playerId)
            playerId = NSNumber(value: tmpPlayerId ?? 0)
        } catch {
            #if DEBUG
            print("An error occurred at Player decoding due to \(error.localizedDescription)")
            #endif
            throw error
        }
    }
}
