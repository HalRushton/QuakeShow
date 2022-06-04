//
//  FeatureGeometry.swift
//  QuakeShow
//
//  Created by Hal Jay Rushton on 6/1/22.
//

import Foundation
import CoreData

struct FeatureGeometry: Decodable {
    let type: String
    let coordinates: QuakeCoordinates
    
    enum CodingKeys: String, CodingKey {
        case type
        case coordinates
    }
        
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type) ?? "unknown"
        let array = try values.decode([Double].self, forKey: .coordinates)
        coordinates = QuakeCoordinates(longitude: array[0], latitude: array[1], depth: array[2])
      }
}
