//
//  CoreDataProvider.swift
//  GVC-Apple-Multiplatform
//
//  Created by Zaid Neurothrone on 2022-10-25.
//

import CoreData
import SwiftUI

final class CoreDataProvider {
  
  // MARK: - Static Properties
  
  static let shared: CoreDataProvider = .init()
  static var preview: CoreDataProvider = {
    let provider = CoreDataProvider(inMemory: true)
    let context = provider.container.viewContext
    
    CalculationModel.Preview.generateSamples(using: context)
    
    return provider
  }()
  
  // MARK: - Initialization
  
  let container: NSPersistentContainer
  
  private init(inMemory: Bool = false) {
    container = NSPersistentContainer(name: "Entities")
    
    if inMemory {
      container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
    }
    
    container.loadPersistentStores { _, error in
#if DEBUG
      if let error = error as NSError? {
        fatalError("❌ -> Unresolved error \(error), \(error.userInfo)")
      }
#endif
    }
    
    container.viewContext.automaticallyMergesChangesFromParent = true
    container.viewContext.name = "viewContext"
    container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    container.viewContext.undoManager = nil
    container.viewContext.shouldDeleteInaccessibleFaults = true
  }
  
  var viewContext: NSManagedObjectContext {
    container.viewContext
  }
}
