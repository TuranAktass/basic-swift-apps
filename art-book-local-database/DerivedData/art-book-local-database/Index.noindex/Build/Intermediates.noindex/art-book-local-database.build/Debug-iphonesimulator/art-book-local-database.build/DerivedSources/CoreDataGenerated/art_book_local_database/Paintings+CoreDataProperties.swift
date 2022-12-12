//
//  Paintings+CoreDataProperties.swift
//  
//
//  Created by Risetime on 11.12.2022.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Paintings {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Paintings> {
        return NSFetchRequest<Paintings>(entityName: "Paintings")
    }

    @NSManaged public var artist: String?
    @NSManaged public var id: UUID?
    @NSManaged public var image: Data?
    @NSManaged public var name: String?
    @NSManaged public var year: Int32

}

extension Paintings : Identifiable {

}
