//
//  Task+CoreDataProperties.swift
//  CoreDataTask
//
//  Created by Mohammed mohsen on 22/12/2020.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var isCompleted: Bool
    @NSManaged public var isFavourite: Bool
    @NSManaged public var taskTitle: String?
    @NSManaged public var taskContent: String?

}

extension Task : Identifiable {

}
