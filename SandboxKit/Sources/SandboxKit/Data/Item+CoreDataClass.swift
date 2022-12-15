//
//  Item+CoreDataClass.swift
//  MultiplatformSandbox
//
//  Created by Zaid Neurothrone on 2022-12-15.
//
//

import CoreData
import Foundation

@objc(Item)
public class Item: NSManagedObject {
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
    return NSFetchRequest<Item>(entityName: String(describing: Item.self))
  }
  
  @NSManaged public var createdDate: Date
  
  public override func awakeFromInsert() {
    super.awakeFromInsert()
    
    createdDate = .now
  }
}

extension Item : Identifiable {}
