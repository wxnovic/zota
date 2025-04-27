//
//  AdminView.swift
//  zota
//
//  Created by emdas93 on 4/25/25.
//

import SwiftUI
import SwiftData

struct AdminView: View {
    @Environment(\.modelContext) private var context

    // ✅ 입력용 State 변수
    @State private var userName = ""
    @State private var categoryTitle = ""
    @State private var itemTitle = ""
    @State private var itemColor = ""
    @State private var taskTitle = ""
    @State private var taskColor = ""
    @State private var taskPassword = ""
    @State private var bombPassword = ""
    
    @Query private var users: [UserModel]
    @Query private var categories: [CategoryModel]
    @Query private var items: [ItemModel]
    @Query private var tasks: [TaskModel]
    @Query private var bombs: [BombModel]

    var body: some View {
        NavigationView {
            Form {
                Section("👤 User") {
                    TextField("이름", text: $userName)
                    Button("저장") {
                        guard !userName.isEmpty else { return }
                        let newUser = UserModel(name: userName)
                        context.insert(newUser)
                        try? context.save()
                        userName = ""
                    }
                    ForEach(users) { user in
                        HStack {
                            Text(user.name)
                            Spacer()
                            Button("삭제") {
                                context.delete(user)
                                try? context.save()
                            }
                        }
                    }
                }

                Section("📂 Category") {
                    TextField("카테고리명", text: $categoryTitle)
                    Button("저장") {
                        guard !categoryTitle.isEmpty else { return }
                        let category = CategoryModel(title: categoryTitle)
                        context.insert(category)
                        try? context.save()
                        categoryTitle = ""
                    }
                    ForEach(categories) { category in
                        HStack {
                            Text(category.title)
                            Spacer()
                            Button("삭제") {
                                context.delete(category)
                                try? context.save()
                            }
                        }
                    }
                }

                Section("🧱 Item") {
                    TextField("아이템명", text: $itemTitle)
                    TextField("색상", text: $itemColor)
                    Button("저장") {
                        guard !itemTitle.isEmpty else { return }
                        let item = ItemModel(title: itemTitle, color: itemColor.isEmpty ? "gray" : itemColor)
                        context.insert(item)
                        try? context.save()
                        itemTitle = ""
                        itemColor = ""
                    }
                    ForEach(items) { item in
                        HStack {
                            Text("\(item.title) (\(item.color))")
                            Spacer()
                            Button("삭제") {
                                context.delete(item)
                                try? context.save()
                            }
                        }
                    }
                }

                Section("✅ Task") {
                    TextField("할 일 제목", text: $taskTitle)
                    TextField("색상", text: $taskColor)
                    TextField("비밀번호 (숫자)", text: $taskPassword)
                        .keyboardType(.numberPad)
                    Button("저장") {
                        guard let pw = Int(taskPassword), !taskTitle.isEmpty else { return }
                        let task = TaskModel(title: taskTitle, color: taskColor, password: pw)
                        context.insert(task)
                        try? context.save()
                        taskTitle = ""
                        taskColor = ""
                        taskPassword = ""
                    }
                    ForEach(tasks) { task in
                        HStack {
                            Text(task.title)
                            Spacer()
                            Button("삭제") {
                                context.delete(task)
                                try? context.save()
                            }
                        }
                    }
                }

                Section("💣 Bomb") {
                    TextField("비밀번호", text: $bombPassword)
                    Button("저장") {
                        guard !bombPassword.isEmpty else { return }
                        let bomb = BombModel(password: bombPassword)
                        context.insert(bomb)
                        try? context.save()
                        bombPassword = ""
                    }
                    ForEach(bombs) { bomb in
                        HStack {
                            Text("비번: \(bomb.password), 상태: \(bomb.state)")
                            Spacer()
                            Button("삭제") {
                                context.delete(bomb)
                                try? context.save()
                            }
                        }
                    }
                }
            }
            .navigationTitle("🛠 어드민 입력/삭제 뷰")
        }
    }
}

#Preview {
    AdminView()
}
