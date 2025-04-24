//
//  ㅇㅇㅇㅇ.swift
//  zota
//
//  Created by emdas93 on 4/24/25.
//
import SwiftUI
import SwiftData

struct DataEntryView: View {
    @Environment(\.modelContext) private var context

    // 입력값 상태
    @State private var userName = ""
    @State private var selectedUser: UserModel?

    @State private var dayDate = Date()
    @State private var selectedDay: DayModel?

    @State private var categoryTitle = ""
    @State private var selectedCategory: CategoryModel?

    @State private var itemTitle = ""
    @State private var itemColor = ""
    @State private var selectedItem: ItemModel?

    @State private var taskTitle = ""
    @State private var taskColor = ""
    @State private var taskPassword = ""

    @State private var bombPassword = ""
    @State private var bombState = 0

    // 관계된 객체 목록
    @Query var users: [UserModel]
    @Query var days: [DayModel]
    @Query var categories: [CategoryModel]
    @Query var items: [ItemModel]

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Group {
                    Text("👤 유저 생성")
                    TextField("유저 이름", text: $userName)
                    Button("유저 생성") {
                        let user = UserModel(name: userName)
                        context.insert(user)
                        selectedUser = user
                    }
                }

                Group {
                    Divider()
                    Text("📅 날짜 생성")
                    DatePicker("날짜 선택", selection: $dayDate, displayedComponents: .date)
                    Button("날짜 생성") {
                        let day = DayModel(date: dayDate)
                        context.insert(day)
                        selectedDay = day
                    }
                }

                Group {
                    Divider()
                    Text("📁 카테고리 생성")
                    TextField("카테고리 제목", text: $categoryTitle)
                    Picker("유저 선택", selection: $selectedUser) {
                        ForEach(users, id: \.id) { user in
                            Text(user.name).tag(Optional(user))
                        }
                    }
                    Button("카테고리 생성") {
                        if let user = selectedUser {
                            let category = CategoryModel(title: categoryTitle, user: user)
                            context.insert(category)
                            selectedCategory = category
                        }
                    }
                }

                Group {
                    Divider()
                    Text("🗂️ 아이템 생성")
                    TextField("아이템 제목", text: $itemTitle)
                    TextField("색상", text: $itemColor)
                    Picker("카테고리 선택", selection: $selectedCategory) {
                        ForEach(categories, id: \.id) { cat in
                            Text(cat.title).tag(Optional(cat))
                        }
                    }
                    Button("아이템 생성") {
                        if let category = selectedCategory {
                            let item = ItemModel(title: itemTitle, color: itemColor, category: category)
                            context.insert(item)
                            selectedItem = item
                        }
                    }
                }

                Group {
                    Divider()
                    Text("📝 태스크 생성")
                    TextField("태스크 제목", text: $taskTitle)
                    TextField("색상", text: $taskColor)
                    TextField("비밀번호 (숫자)", text: $taskPassword)
                        .keyboardType(.numberPad)
                    Picker("아이템 선택", selection: $selectedItem) {
                        ForEach(items, id: \.id) { item in
                            Text(item.title).tag(Optional(item))
                        }
                    }
                    Picker("날짜 선택", selection: $selectedDay) {
                        ForEach(days, id: \.id) { day in
                            Text(day.date.formatted()).tag(Optional(day))
                        }
                    }
                    Button("태스크 생성") {
                        if let item = selectedItem, let day = selectedDay, let pw = Int(taskPassword) {
                            let task = TaskModel(title: taskTitle, color: taskColor, password: pw, item: item, day: day)
                            context.insert(task)
                        }
                    }
                }

                Group {
                    Divider()
                    Text("💣 폭탄 생성")
                    TextField("비밀번호", text: $bombPassword)
                    Stepper("상태: \(bombState)", value: $bombState)
                    Picker("날짜 선택", selection: $selectedDay) {
                        ForEach(days, id: \.id) { day in
                            Text(day.date.formatted()).tag(Optional(day))
                        }
                    }
                    Button("폭탄 생성") {
                        if let day = selectedDay {
                            let bomb = BombModel(password: bombPassword, state: bombState, day: day)
                            context.insert(bomb)
                        }
                    }
                }
            }
            .padding()
        }
    }
}
