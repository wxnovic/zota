//
//  Untitled.swift
//  zota
//
//  Created by Aaron on 4/25/25.
//


import SwiftUI

struct TaskCreateView: View {
    @State private var taskTitles = ["레포트", "시험", "발표", "과제"]
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
