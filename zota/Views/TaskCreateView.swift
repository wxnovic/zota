//
//  Untitled.swift
//  zota
//
//  Created by Aaron on 4/25/25.
//


import SwiftUI

struct TaskCreateView: View {
    @State private var taskTitles = ["레포트", "시험", "발표"]
    @State private var showInputPopup = false
    @State private var newTaskText = ""
    @State private var isEditMode = false
    @State private var selectedTask: String? = nil // ✅ 현재 선택된 버튼

    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ZStack {
            Image("wallpaper")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .onTapGesture {
                    if isEditMode {
                        withAnimation { isEditMode = false }
                    } else {
                        selectedTask = nil // ✅ 선택 상태 초기화
                    }
                }

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

            if showInputPopup {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .zIndex(1)

                VStack(spacing: 20) {
                    Text("새로운 항목 추가")
                        .font(.headline)
                        .padding(.top)

                    TextField("예: 과제, 일정 등", text: $newTaskText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)

                    HStack(spacing: 20) {
                        Button("확인") {
                            let trimmed = newTaskText.trimmingCharacters(in: .whitespaces)
                            if !trimmed.isEmpty {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    taskTitles.append(trimmed)
                                    newTaskText = ""
                                    showInputPopup = false
                                }
                            }
                        }
                        .frame(width: 100, height: 36)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)

                        Button("취소") {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                showInputPopup = false
                            }
                        }
                        .frame(width: 100, height: 36)
                        .background(Color.gray.opacity(0.3))
                        .foregroundColor(.black)
                        .cornerRadius(8)
                    }
                    .padding(.bottom)
                }
                .frame(width: 300)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 20)
                .transition(.opacity)
                .zIndex(2)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: showInputPopup)
    }
}

#Preview {
    TaskCreateView()
}
