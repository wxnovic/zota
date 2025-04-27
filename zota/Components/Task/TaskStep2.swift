//
//  TaskStep2.swift
//  zota
//
//  Created by emdas93 on 4/26/25.
//
import SwiftUI

struct TaskStep2: View {
    @State private var selectedButton: Int?
    var taskCreateModel: TaskCreateModel
    

    var body: some View {
        VStack {
            Text("언제까지?")
                .font(.system(size: 30, weight: .bold, design: .default))
                .shadow(radius: 5)
                .padding(.top)

            let columns = [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ]
            
            ScrollView {
                LazyVGrid(columns: columns, alignment: .center) {
                    ForEach(Array(taskCreateModel.dates.enumerated()), id: \.offset) { index, date in
                        Button(action: {
                            selectedButton = index
                            taskCreateModel.selectedDay = index + 1
                            print(taskCreateModel.selectedDay ?? 0) // 디버깅용 출력
                        }) {
                            Text(date)
                                .font(.system(size: 20, weight: .bold, design: .default))
                                .frame(width: 80, height: 50)
                                .background(selectedButton == index ? Color.black.opacity(0.5) : Color.white.opacity(0.5))
                                .cornerRadius(20)
                                .foregroundStyle(.black)
                        }
                        .padding()
                    }
                }
            }

            
            Spacer()
        }
        .frame(width: 350, height: 250)
        .background(Color.black.opacity(0.1))
        .cornerRadius(20)
        .padding()
        .onAppear {
            selectedButton = (taskCreateModel.selectedDay ?? 0) - 1
        }
    }
}

#Preview {
    let taskCreateModel = TaskCreateModel()
    TaskStep2(taskCreateModel: taskCreateModel)
}
