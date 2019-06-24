//
//  PlayerFinderResponse.swift
//  Cricket
//
//  Created by Nileshkumar Mukeshbhai Prajapati on 19/06/19.
//  Copyright © 2019 Saturn. All rights reserved.
//

import Foundation

// MARK: - ================================
// MARK: Provider information for a specific 'Player Finder'
// MARK: ================================

struct Provider: Codable {
    var pubDate: String?
    var providerURL: String?
    
    private enum CodingKeys: String, CodingKey {
        case pubDate
        case providerURL = "url"
    }
    
    func encode(to encoder: Encoder) throws {
        var values = encoder.container(keyedBy: CodingKeys.self)
        do {
            try values.encodeIfPresent(pubDate, forKey: .pubDate)
            try values.encodeIfPresent(providerURL, forKey: .providerURL)
        } catch {
            print("An error occurred at Provider encoding due to \(error.localizedDescription)")
            throw error
        }
    }
    
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            pubDate = try? values.decode(String.self, forKey: .pubDate)
            providerURL = try? values.decode(String.self, forKey: .providerURL)
        } catch {
            #if DEBUG
            print("An error occurred at Provider decoding due to \(error.localizedDescription)")
            #endif
            throw error
        }
    }
}

// MARK: - ================================
// MARK: Player Finder with multiple players informations
// MARK: ================================

struct PlayerFinder: Codable {
    var provider: Provider?
    var credits: NSNumber?
    var players: [Player]?
    
    private enum CodingKeys: String, CodingKey {
        case provider
        case credits = "creditsLeft"
        case players = "data"
    }
    
    func encode(to encoder: Encoder) throws {
        var values = encoder.container(keyedBy: CodingKeys.self)
        do {
            try values.encodeIfPresent(provider, forKey: .provider)
            try values.encodeIfPresent(credits?.intValue, forKey: .credits)
            try values.encodeIfPresent(players, forKey: .players)
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
            provider = try? values.decode(Provider.self, forKey: .provider)
            let tmpcredits = try? values.decode(Int.self, forKey: .credits)
            credits = NSNumber(value: tmpcredits ?? 0)
            players = try? values.decode([Player].self, forKey: .players)
        } catch {
            #if DEBUG
            print("An error occurred at Player decoding due to \(error.localizedDescription)")
            #endif
            throw error
        }
    }
}
