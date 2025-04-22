//
//  Task.swift
//  zota
//
//  Created by emdas93 on 4/22/25.
//
import CoreData

class Task: TaskProtocol {
    var id: UUID
    var title: String
    var description: String?
    var isCompleted: Bool
    var createdAt: Date
    var updatedAt: Date
    var priority: Int16
    var note: String?
    var dayBlock: UUID
    

    init(id: UUID, title: String, description: String? = nil, isCompleted: Bool, createdAt: Date, updatedAt: Date, priority: Int16, note: String? = nil, dayBlock: UUID) {
        self.id = id
        self.title = title
        self.description = description
        self.isCompleted = isCompleted
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.priority = priority
        self.note = note
        self.dayBlock = dayBlock
    }
    
    func toggleCompleted() {
        isCompleted.toggle()
        updatedAt = Date()
    }
}
