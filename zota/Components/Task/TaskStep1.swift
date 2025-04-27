//
//  TaskStep1.swift
//  zota
//
//  Created by emdas93 on 4/26/25.
//

import SwiftUI
import SwiftData

struct TaskStep1: View {
    @Query private var categories: [CategoryModel]
    var taskCreateModel: TaskCreateModel
    @State private var selectedButton: Int64? = nil
    
    var body: some View {
        VStack(){
            Text("내가 할 일은?")
                .font(.system(size: 30, weight: .bold, design: .default))
                .shadow(radius: 5)
                .padding(.top)

            // Grid Layout을 사용하기 위한 변수
            let columns = [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ]
            
            // 그리드 레이아웃
            ScrollView{
                LazyVGrid(columns: columns, spacing:5) {
                    
                    ForEach(categories){ category in
                        Button(action: {
                            selectedButton = category.id
                            taskCreateModel.selectedCategoryId = category.id
                        }) {
                            Text(category.title)
                                .font(.system(size: 20, weight: .bold, design: .default))
                                .frame(width: 100, height: 50)
                                .background(selectedButton == category.id ? Color.black.opacity(0.5) : Color.white.opacity(0.5))
                                .cornerRadius(20)
                                .foregroundStyle(.black)
                        }
                        .padding()
                    }
                    
                    
                    Button(action: {
                        // 추가 버튼 눌렀을 때 실행할 코드
                    }) {
                        Image(systemName: "plus")
                            .frame(width: 100, height: 50)
                            .background(Color.white.opacity(0.5))
                            .cornerRadius(20)
                            .foregroundStyle(.black)
                    }
                    .padding()
                }
            }
            Spacer()

                
        }
        .frame(width: 350, height: 250)
        .background(Color.black.opacity(0.1))
        .cornerRadius(20)
        .padding()
        .onAppear {
            selectedButton = taskCreateModel.selectedCategoryId
        }
    }
}

#Preview {
    var taskCreateModel: TaskCreateModel = TaskCreateModel()
    TaskStep1(taskCreateModel: taskCreateModel)
}
