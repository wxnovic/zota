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

    @Relationship(deleteRule: .cascade, inverse: \CategoryModel.user)
    var categories: [CategoryModel]

    init(id: Int64 = Int64(Date().timeIntervalSince1970), name: String) {
        self.id = id
        self.name = name
        let now = Date()
        self.createdAt = now
        self.updatedAt = now
        self.categories = []
    }
}

// MARK: - Day
@Model
final class DayModel {
    @Attribute(.unique) var id: Int64
    var date: Date
    var createdAt: Date
    var updatedAt: Date

    @Relationship(deleteRule: .cascade, inverse: \TaskModel.day)
    var tasks: [TaskModel]

    @Relationship(deleteRule: .cascade, inverse: \BombModel.day)
    var bombs: [BombModel]

    init(id: Int64 = Int64(Date().timeIntervalSince1970), date: Date) {
        self.id = id
        self.date = date
        let now = Date()
        self.createdAt = now
        self.updatedAt = now
        self.tasks = []
        self.bombs = []
    }
}

// MARK: - Category
@Model
final class CategoryModel {
    @Attribute(.unique) var id: Int64
    var title: String
    var createdAt: Date
    var updatedAt: Date

    @Relationship var user: UserModel
    @Relationship(deleteRule: .cascade, inverse: \ItemModel.category)
    var items: [ItemModel]

    init(id: Int64 = Int64(Date().timeIntervalSince1970), title: String, user: UserModel) {
        self.id = id
        self.title = title
        self.user = user
        let now = Date()
        self.createdAt = now
        self.updatedAt = now
        self.items = []
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

    @Relationship var category: CategoryModel
    @Relationship(deleteRule: .cascade, inverse: \TaskModel.item)
    var tasks: [TaskModel]

    init(id: Int64 = Int64(Date().timeIntervalSince1970), title: String, color: String, category: CategoryModel) {
        self.id = id
        self.title = title
        self.color = color
        self.category = category
        let now = Date()
        self.createdAt = now
        self.updatedAt = now
        self.tasks = []
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

    @Relationship var item: ItemModel
    @Relationship var day: DayModel

    init(id: Int64 = Int64(Date().timeIntervalSince1970), title: String, color: String, isDone: Bool = false, password: Int, item: ItemModel, day: DayModel) {
        self.id = id
        self.title = title
        self.color = color
        self.isDone = isDone
        self.password = password
        self.item = item
        self.day = day
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

    @Relationship var day: DayModel

    init(id: Int64 = Int64(Date().timeIntervalSince1970), password: String, state: Int = 0, day: DayModel) {
        self.id = id
        self.password = password
        self.state = state
        self.day = day
        let now = Date()
        self.createdAt = now
        self.updatedAt = now
    }
}
