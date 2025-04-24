//
//  DataSelectView.swift
//  zota
//
//  Created by emdas93 on 4/24/25.
//

import SwiftUI
import SwiftData

struct MasterListView: View {
    @Query var users: [UserModel]
    @Query var days: [DayModel]
    @Query var categories: [CategoryModel]
    @Query var items: [ItemModel]
    @Query var tasks: [TaskModel]
    @Query var bombs: [BombModel]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Group {
                    Text("👤 Users").font(.title2).bold()
                    ForEach(users, id: \.id) { user in
                        VStack(alignment: .leading) {
                            Text("🆔 \(user.id)")
                            Text("이름: \(user.name)")
                            Text("생성일: \(user.createdAt.formatted())")
                            Text("카테고리 수: \(user.categories.count)")
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    }
                }

                Group {
                    Text("📅 Days").font(.title2).bold()
                    ForEach(days, id: \.id) { day in
                        VStack(alignment: .leading) {
                            Text("🗓️ 날짜: \(day.date.formatted())")
                            Text("할 일 수: \(day.tasks.count), 폭탄 수: \(day.bombs.count)")
                        }
                        .padding()
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(8)
                    }
                }

                Group {
                    Text("📁 Categories").font(.title2).bold()
                    ForEach(categories, id: \.id) { cat in
                        VStack(alignment: .leading) {
                            Text("제목: \(cat.title)")
                            Text("유저: \(cat.user.name)")
                            Text("아이템 수: \(cat.items.count)")
                        }
                        .padding()
                        .background(Color.orange.opacity(0.1))
                        .cornerRadius(8)
                    }
                }

                Group {
                    Text("🗂️ Items").font(.title2).bold()
                    ForEach(items, id: \.id) { item in
                        VStack(alignment: .leading) {
                            Text("제목: \(item.title)")
                            Text("색상: \(item.color)")
                            Text("카테고리: \(item.category.title)")
                            Text("태스크 수: \(item.tasks.count)")
                        }
                        .padding()
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(8)
                    }
                }

                Group {
                    Text("📝 Tasks").font(.title2).bold()
                    ForEach(tasks, id: \.id) { task in
                        VStack(alignment: .leading) {
                            Text("제목: \(task.title)")
                            Text("색상: \(task.color)")
                            Text("비밀번호: \(task.password)")
                            Text("완료 여부: \(task.isDone ? "✅" : "❌")")
                            Text("아이템: \(task.item.title)")
                            Text("날짜: \(task.day.date.formatted())")
                        }
                        .padding()
                        .background(Color.pink.opacity(0.1))
                        .cornerRadius(8)
                    }
                }

                Group {
                    Text("💣 Bombs").font(.title2).bold()
                    ForEach(bombs, id: \.id) { bomb in
                        VStack(alignment: .leading) {
                            Text("비밀번호: \(bomb.password)")
                            Text("상태: \(bomb.state)")
                            Text("날짜: \(bomb.day.date.formatted())")
                        }
                        .padding()
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(8)
                    }
                }
            }
            .padding()
        }
    }
}
