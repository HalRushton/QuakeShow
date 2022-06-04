//
//  FeatureProperties.swift
//  QuakeShow
//
//  Created by Hal Jay Rushton on 6/1/22.
//

import Foundation
import CoreData

/// Feature Descriptions
/// https://earthquake.usgs.gov/data/comcat/data-eventterms.php#metadata_url
/// 
struct FeatureProperties: Decodable {
    let mag: Double?
    let place: String?
    let time: Int64?
    let updated: Int64
    let tz: Int16?
    let url: String?
    let detail: String?
    let felt: Int16?
    let cdi: Double?
    let mmi: Double?
    let alert: String?
    let status: String?
    let tsunami: Int16?
    let sig: Int16?
    let net: String?
    let code: String?
    let ids: String?
    let sources: String?
    let types: String?
    let nst: Int16?
    let dmin: Double?
    let rms: Double?
    let gap: Double?
    let magType: String?
    let title: String?
    
    func saveItem(context: NSManagedObjectContext) -> FeaturePropertiesItem {
        let item = FeaturePropertiesItem(context: context)
        item.alert = alert
        item.cdi = cdi ?? 0
        item.code = code
        item.detail = detail
        item.dmin = dmin ?? 0
        item.felt = felt ?? 0
        item.gap = gap ?? 0
        item.ids = ids
        item.mag = mag ?? 0
        item.magType = magType
        item.mmi = mmi ?? 0
        item.net = net
        item.nst = nst ?? 0
        item.place = place
        item.rms = rms ?? 0
        item.sig = sig ?? 0
        item.sources = sources
        item.status = status
        item.time = time ?? 0
        item.tsunami = tsunami ?? 0
        item.types = types
        item.tz = tz ?? 0
        item.updatedTime = updated
        item.url = url
        return item
    }
}
