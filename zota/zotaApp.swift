//
//  zotaApp.swift
//  zota
//
//  Created by Chu on 4/22/25.
//

import SwiftUI
import SwiftData

@main
struct zotaApp: App {
    @Environment(\.modelContext) var context: ModelContext

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                        Task {
                            await preloadDummyDataIfNeeded(context: context)
                        }
                    }
        }
        .modelContainer(for: [
            UserModel.self,
            CategoryModel.self,
            ItemModel.self,
            TaskModel.self,
            DayModel.self,
            BombModel.self
        ])
        
    }
    
    
}
@MainActor
func preloadDummyDataIfNeeded(context: ModelContext) async {
    do {
        let users = try context.fetch(FetchDescriptor<UserModel>())
        guard users.isEmpty else {
            print("🔍 이미 더미 데이터 존재, 스킵")
            return
        }

        print("🚀 더미 데이터 생성 시작")

        let user = UserModel(name: "홍길동")
        context.insert(user)

        let categories = [
            CategoryModel(title: "업무", user: user),
            CategoryModel(title: "개인", user: user)
        ]
        categories.forEach { context.insert($0) }

        var items: [ItemModel] = []
        for (index, category) in categories.enumerated() {
            for i in 1...2 {
                let item = ItemModel(
                    title: "\(category.title) 아이템 \(i)",
                    color: index == 0 ? "blue" : "green",
                    category: category
                )
                items.append(item)
                context.insert(item)
            }
        }

        var days: [DayModel] = []
        for i in 0..<3 {
            let date = Calendar.current.date(byAdding: .day, value: -i, to: Date())!
            let day = DayModel(date: date)
            days.append(day)
            context.insert(day)
        }

        var taskIDCounter: Int64 = 1000
        for day in days {
            for i in 1...3 {
                let item = items.randomElement()!
                let task = TaskModel(
                    id: taskIDCounter,
                    title: "태스크 \(i) (\(day.date.formatted(date: .numeric, time: .omitted)))",
                    color: "gray",
                    password: i,
                    item: item,
                    day: day
                )
                taskIDCounter += 1
                context.insert(task)
            }

            let bomb = BombModel(password: "000\(Int.random(in: 1...9))", day: day)
            context.insert(bomb)
        }

        try context.save()
        print("✅ 더미 데이터 삽입 완료")
    } catch {
        print("❌ 더미 데이터 삽입 실패: \(error)")
    }
}
