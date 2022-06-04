//
//  Feature.swift
//  Quake
//
//  Created by Hal Jay Rushton on 5/30/22.
//

import Foundation
import CoreLocation
import CoreData

/// DTO Description
/// https://earthquake.usgs.gov/earthquakes/feed/v1.0/geojson.php
struct FeatureCollection: Decodable {
    let metadata: CollectionMetadata
    let bbox: [Double]//TODO BoundingBox
    let features: [Feature]
}

struct CollectionMetadata: Decodable {
    let generated: Int64
    let url: String
    let title: String
    let api: String
    let count: Int
    let status: Int
}

struct Feature: Decodable {
    let properties: FeatureProperties
    let geometry: FeatureGeometry
    let id: String
}
