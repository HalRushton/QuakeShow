//
//  QuakeListViewModel.swift
//  QuakeShow
//
//  Created by Hal Jay Rushton on 6/4/22.
//

import Foundation
import SwiftUI
import Combine

class QuakeListViewModel: ObservableObject {
    @Published var quakes: [QuakeItem] = []
    @Published var searchText: String = ""
    @Published var sortType: SortViewType = .magnitude
    @Published var sortAscending: Bool = false
    private var cancellables: Set<AnyCancellable> = []
    
    init(quakePublisher: AnyPublisher<[QuakeItem], Never>) {
        quakePublisher.sink { quakes in
            self.quakes = quakes
        }.store(in: &cancellables)
    }
    
    var searchResults: [QuakeItem] {
        if searchText.isEmpty {
            return quakes.map { $0 }
        } else {
            return quakes.filter { $0.title?.lowercased().contains(searchText.lowercased()) == true }.sorted { lhs, rhs in
                switch sortType {
                case .magnitude:
                    if sortAscending {
                        return lhs.magnitude < rhs.magnitude
                    } else {
                        return lhs.magnitude > rhs.magnitude
                    }
                case .date:
                    if sortAscending {
                        return lhs.time < rhs.time
                    } else {
                        return lhs.time > rhs.time
                    }
                case .name:
                    guard let lhsTitle = lhs.title,
                          let rhsTitle = rhs.title
                    else { return false }
                    
                    if sortAscending {
                        return lhsTitle < rhsTitle
                    } else {
                        return lhsTitle > rhsTitle
                    }
                }
            }
        }
    }
}
