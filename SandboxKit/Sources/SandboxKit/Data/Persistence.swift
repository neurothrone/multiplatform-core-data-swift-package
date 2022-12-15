//
//  Persistence.swift
//  
//
//  Created by Zaid Neurothrone on 2022-12-15.
//

import CoreData
import Foundation

public struct PersistenceController {
  public static let shared = PersistenceController()
  
  public static var preview: PersistenceController = {
    let result = PersistenceController(inMemory: true)
    let viewContext = result.container.viewContext
    for _ in 0..<10 {
      let newItem = Item(context: viewContext)
    }
    do {
      try viewContext.save()
    } catch {
      // Replace this implementation with code to handle the error appropriately.
      // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
      let nsError = error as NSError
      fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }
    return result
  }()
  
  private let container: NSPersistentContainer
  
  public var viewContext: NSManagedObjectContext {
    container.viewContext
  }
  
  private init(inMemory: Bool = false) {
    let dataModelFileName = "Entities"
    
    // NOTE: Bundle.module and not Bundle.main
    // NOTE: Extension must be "momd"
    guard let modelURL = Bundle.module.url(
      forResource: dataModelFileName,
      withExtension: "momd"),
          let model = NSManagedObjectModel(contentsOf: modelURL)
    else { fatalError("Failed to find Data Model by the name \(dataModelFileName)") }
    
    container = NSPersistentContainer(name: "Entities", managedObjectModel: model)
    
    if inMemory {
      container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
    }
    
    container.loadPersistentStores { storeDescription, error in
      if let error = error as NSError? {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        
        /*
         Typical reasons for an error here include:
         * The parent directory does not exist, cannot be created, or disallows writing.
         * The persistent store is not accessible, due to permissions or data protection when the device is locked.
         * The device is out of space.
         * The store could not be migrated to the current model version.
         Check the error message to determine what the actual problem was.
         */
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
    
    container.viewContext.automaticallyMergesChangesFromParent = true
  }
}
