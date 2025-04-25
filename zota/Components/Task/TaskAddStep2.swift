//
//  TaskAddStep1.swift
//  zota
//
//  Created by 윤 on 4/25/25.
//

import SwiftUI
import SwiftData

struct TaskAddStep2: View {
    @State private var taskTitles = ["레포트", "시험", "발표", "과제"]
    @State private var showInputPopup = false
    @State private var newTaskText = ""
    @State private var isEditMode = false
    @State private var selectedTask: String? = nil // ✅ 현재 선택된 버튼
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        RoundedRectangle(cornerRadius: 35)
            .fill(.ultraThinMaterial)
            .opacity(0.85)
            .frame(width: 340, height: 280)
            .overlay(
                VStack(spacing: 10) {
                    Text("내가 할 일은?")
                        .font(.system(size: 30, weight: .heavy))
                        .foregroundColor(.black)
                        .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
                        .padding(.top, 10)

                    ScrollView(.vertical, showsIndicators: true) {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(taskTitles, id: \.self) { title in
                                TaskButton(
                                    title: title,
                                    isEditMode: isEditMode,
                                    isSelected: selectedTask == title,
                                    onDelete: {
                                        withAnimation {
                                            taskTitles.removeAll { $0 == title }
                                        }
                                    },
                                    onTap: {
                                        if !isEditMode {
                                            selectedTask = title // ✅ 선택된 버튼 갱신
                                        }
                                    },
                                    onLongPress: {
                                        withAnimation {
                                            isEditMode = true
                                        }
                                        let generator = UIImpactFeedbackGenerator(style: .medium)
                                        generator.impactOccurred()
                                    }
                                )
                            }

                            TaskButton(
                                title: "+",
                                isEditMode: false,
                                isPlus: true,
                                isSelected: false,
                                onDelete: {},
                                onTap: {
                                    withAnimation(.easeInOut(duration: 0.3)) {
                                        showInputPopup = true
                                    }
                                },
                                onLongPress: {}
                            )
                        }
                        .padding()
                    }
                    .scrollIndicators(.visible) // ✅ 스크롤바 항상 보이기
                    .frame(height: 180)
                }
                .padding(.horizontal)
            )

    }
}
#Preview {
    TaskAddStep1()
}
