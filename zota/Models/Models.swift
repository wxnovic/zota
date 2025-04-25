//
//  Models.swift
//  zota
//
//  Created by emdas93 on 4/24/25.
//
import Foundation
import SwiftData

// MARK: - User
@Model
final class UserModel {
    @Attribute(.unique) var id: Int64
    var name: String
    var createdAt: Date
    var updatedAt: Date

    init(id: Int64 = Int64(Date().timeIntervalSince1970), name: String) {
        self.id = id
        self.name = name
        let now = Date()
        self.createdAt = now
        self.updatedAt = now
    }
}

// MARK: - Day
@Model
final class DayModel {
    @Attribute(.unique) var id: Int64
    var date: Date
    var createdAt: Date
    var updatedAt: Date

    init(id: Int64 = Int64(Date().timeIntervalSince1970), date: Date) {
        self.id = id
        self.date = date
        let now = Date()
        self.createdAt = now
        self.updatedAt = now
    }
}

// MARK: - Category
@Model
final class CategoryModel {
    @Attribute(.unique) var id: Int64
    var title: String
    var createdAt: Date
    var updatedAt: Date
    var userId: Int64?

    init(id: Int64 = Int64(Date().timeIntervalSince1970), title: String, userId: Int64? = nil) {
        self.id = id
        self.title = title
        self.userId = userId
        let now = Date()
        self.createdAt = now
        self.updatedAt = now
    }
}

// MARK: - Item
@Model
final class ItemModel {
    @Attribute(.unique) var id: Int64
    var title: String
    var color: String
    var createdAt: Date
    var updatedAt: Date
    var categoryId: Int64?
    var isDeleted: Bool = false

    init(id: Int64 = Int64(Date().timeIntervalSince1970), title: String, color: String, categoryId: Int64? = nil) {
        self.id = id
        self.title = title
        self.color = color
        self.categoryId = categoryId
        let now = Date()
        self.createdAt = now
        self.updatedAt = now
    }
}

// MARK: - Task
@Model
final class TaskModel {
    @Attribute(.unique) var id: Int64
    var title: String
    var color: String
    var isDone: Bool
    var password: Int
    var createdAt: Date
    var updatedAt: Date
    var itemId: Int64?
    var dayId: Int64?

    init(id: Int64 = Int64(Date().timeIntervalSince1970), title: String, color: String, isDone: Bool = false, password: Int, itemId: Int64? = nil, dayId: Int64? = nil) {
        self.id = id
        self.title = title
        self.color = color
        self.isDone = isDone
        self.password = password
        self.itemId = itemId
        self.dayId = dayId
        let now = Date()
        self.createdAt = now
        self.updatedAt = now
    }
}

// MARK: - Bomb
@Model
final class BombModel {
    @Attribute(.unique) var id: Int64
    var password: String
    var state: Int
    var createdAt: Date
    var updatedAt: Date
    var dayId: Int64?

    init(id: Int64 = Int64(Date().timeIntervalSince1970), password: String, state: Int = 0, dayId: Int64? = nil) {
        self.id = id
        self.password = password
        self.state = state
        self.dayId = dayId
        let now = Date()
        self.createdAt = now
        self.updatedAt = now
    }
}
