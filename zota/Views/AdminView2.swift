//
//  AdminView2.swift
//  zota
//
//  Created by emdas93 on 4/25/25.
//

import SwiftUI
import SwiftData

struct AdminView2: View {
    @Query private var users: [UserModel]
    @Query private var categories: [CategoryModel]
    @Query private var items: [ItemModel]
    @Query private var tasks: [TaskModel]
    @Query private var bombs: [BombModel]
    @Query private var days: [DayModel]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                SectionView(title: "👤 Users") {
                    ForEach(users) { user in
                        Text("• \(user.name) (생성: \(formatted(user.createdAt)))")
                    }
                }

                SectionView(title: "📂 Categories") {
                    ForEach(categories) { category in
                        Text("• \(category.title) (ID: \(category.id))")
                    }
                }

                SectionView(title: "🧱 Items") {
                    ForEach(items) { item in
                        Text("• \(item.title) [\(item.color)]")
                    }
                }

                SectionView(title: "✅ Tasks") {
                    ForEach(tasks) { task in
                        VStack(alignment: .leading) {
                            Text("• \(task.title)")
                            Text("  - 색상: \(task.color)")
                            Text("  - 완료: \(task.isDone ? "O" : "X")")
                            Text("  - 비밀번호: \(task.password)")
                        }
                    }
                }

                SectionView(title: "💣 Bombs") {
                    ForEach(bombs) { bomb in
                        Text("• 비밀번호: \(bomb.password), 상태: \(bomb.state)")
                    }
                }

                SectionView(title: "📅 Days") {
                    ForEach(days) { day in
                        Text("• 날짜: \(formatted(day.date))")
                    }
                }
            }
            .padding()
        }
        .navigationTitle("📊 데이터 보기")
    }

    // 날짜 형식
    private func formatted(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd HH:mm"
        return formatter.string(from: date)
    }
}

// 🧩 각 Section 스타일 공통 컴포넌트
struct SectionView<Content: View>: View {
    var title: String
    var content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .padding(.bottom, 4)
            content()
                .padding(.leading, 8)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(12)
    }
}

#Preview {
    AdminView2()
}
