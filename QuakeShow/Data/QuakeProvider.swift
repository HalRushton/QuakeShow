//
//  QuakeProvider.swift
//  QuakeShow
//
//  Created by Hal Jay Rushton on 6/4/22.
//

import Foundation
import CoreData
import Combine

class QuakeProvider: NSObject, ObservableObject {
    var quakes = CurrentValueSubject<[QuakeItem], Never>([])
    private let quakeFetchController: NSFetchedResultsController<QuakeItem>
    static let shared: QuakeProvider = QuakeProvider()
    
    private override init() {
        let fetchRequest = QuakeItem.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        quakeFetchController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: PersistenceController.shared.container.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        super.init()
        
        quakeFetchController.delegate = self
        do {
            try quakeFetchController.performFetch()
            quakes.value = quakeFetchController.fetchedObjects ?? []
        } catch {
            assert(true, "could not fetch objects")
        }
    }
}

extension QuakeProvider: NSFetchedResultsControllerDelegate {
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let quakes = controller.fetchedObjects as? [QuakeItem] else {
            assert(true, "bad fetched object")
            return
        }
        
        print("context has changed, reloading quakes")
        self.quakes.value = quakes
    }
}
