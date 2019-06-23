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
    var url: String?
    
    private enum CodingKeys: String, CodingKey {
        case pubDate
        case url
    }
    
    func encode(to encoder: Encoder) throws {
        var values = encoder.container(keyedBy: CodingKeys.self)
        do {
            try values.encodeIfPresent(pubDate, forKey: .pubDate)
            try values.encodeIfPresent(url, forKey: .url)
        } catch {
            print("An error occurred at Provider encoding due to \(error.localizedDescription)")
            throw error
        }
    }
    
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            pubDate = try? values.decode(String.self, forKey: .pubDate)
            url = try? values.decode(String.self, forKey: .url)
        } catch {
            print("An error occurred at Provider decoding due to \(error.localizedDescription)")
            throw error
        }
    }
}

// MARK: - ================================
// MARK: Player Finder with multiple players informations
// MARK: ================================

struct PlayerFinder: Codable {
    var ttl: NSNumber?
    var provider: Provider?
    var credits: NSNumber?
    var players: [Player]?
    
    private enum CodingKeys: String, CodingKey {
        case ttl
        case provider
        case credits = "creditsLeft"
        case players = "data"
    }
    
    func encode(to encoder: Encoder) throws {
        var values = encoder.container(keyedBy: CodingKeys.self)
        do {
            try values.encodeIfPresent(ttl?.intValue, forKey: .ttl)
            try values.encodeIfPresent(provider, forKey: .provider)
            try values.encodeIfPresent(credits?.intValue, forKey: .credits)
            try values.encodeIfPresent(players, forKey: .players)
        } catch {
            print("An error occurred at Player encoding due to \(error.localizedDescription)")
            throw error
        }
    }
    
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            let tmpttl = try? values.decode(Int.self, forKey: .ttl)
            ttl = NSNumber(value: tmpttl ?? 0)
            provider = try? values.decode(Provider.self, forKey: .provider)
            let tmpcredits = try? values.decode(Int.self, forKey: .credits)
            credits = NSNumber(value: tmpcredits ?? 0)
            players = try? values.decode([Player].self, forKey: .players)
        } catch {
            print("An error occurred at Player decoding due to \(error.localizedDescription)")
            throw error
        }
    }
}
