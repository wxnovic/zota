//
//  DayBlock.swift
//  zota
//
//  Created by Aaron on 4/22/25.
//
import CoreData

class DayBlock: DayBlockProtocol {
    var id: UUID
    var title: String
    var description: String?
    var dayCounts: Int
    var createdAt: Date
    var updatedAt: Date
    
    init(id: UUID, title: String, description: String? = nil, dayCounts: Int, createdAt: Date, updatedAt: Date) {
        self.id = id
        self.title = title
        self.description = description
        self.dayCounts = dayCounts
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
