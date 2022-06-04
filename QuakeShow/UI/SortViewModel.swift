//
//  SortViewModel.swift
//  QuakeShow
//
//  Created by Hal Jay Rushton on 6/4/22.
//

import Foundation
import SwiftUI

class SortViewModel: ObservableObject {
    var sortViewType: Binding<SortViewType>
    var sortAscending: Binding<Bool>
    
    init(sortViewType: Binding<SortViewType>, sortAscending: Binding<Bool>) {
        self.sortAscending = sortAscending
        self.sortViewType = sortViewType
    }
    
    func imageName(type: SortViewType) -> String? {
        if sortViewType.wrappedValue == type {
            return sortAscending.wrappedValue ? "arrow.up" : "arrow.down"
        } else {
            return nil
        }
    }
}
