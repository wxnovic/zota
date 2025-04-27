//
//  TaskStep2.swift
//  zota
//
//  Created by emdas93 on 4/26/25.
//

import SwiftUI
import SwiftData

struct TaskStep3: View {
    var taskCreateModel: TaskCreateModel
    @Query private var items: [ItemModel]
    
    @State var selectedTask: Int64 = 0
    
    var body: some View {
        VStack {
            // 상단
            HStack(spacing: 10){
                
                ForEach(0..<4, id: \.self) {index in
                    if(index < taskCreateModel.selectedDay ?? 4){
                        Button(action: {
                            if((selectedTask) != 0){
                                taskCreateModel.taskDatas[index].title = items.first(where: {$0.id == selectedTask})?.title ?? "not found"
                                taskCreateModel.taskDatas[index].date = taskCreateModel.dates[index]
                                taskCreateModel.taskDatas[index].categoryId = taskCreateModel.selectedCategoryId ?? 1
                                print(taskCreateModel.taskDatas[index].title)
                                print(taskCreateModel.taskDatas[index].date)
                                print(taskCreateModel.taskDatas[index].categoryId)
                            }
                        }) {
                            VStack{
                                Text(taskCreateModel.weekdays[index])
                                    .font(.system(size: 20, weight: .bold, design: .default))
                                    .foregroundColor({
                                        switch taskCreateModel.weekdays[index] {
                                        case "Sun":
                                            return .red
                                        case "Sat":
                                            return .blue
                                        default:
                                            return .black
                                        }
                                    }())
                                ForEach(taskCreateModel.taskDatas, id:\.title ){task in
                                    Text("TEST")
                                }
                            }
                            .frame(width: 80, height: 150, alignment: .top)
                            .background(Color(hex: "E9EAF0"))
                            .cornerRadius(20)
                            
                            
                            
                            
                            
                
                        }
                    }
                }
     
            }
            .frame(width: 370, height: 200)
            .background(Color.black.opacity(0.1))
            .cornerRadius(20)
            .padding()
            
            VStack(){

                // Grid Layout을 사용하기 위한 변수
                let columns = [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ]
                
                // 그리드 레이아웃
                ScrollView{
                    LazyVGrid(columns: columns, spacing:5) {
                        
                        ForEach(items, id: \.id){ item in
                            Button(action: {
                                selectedTask = item.id
                                print(selectedTask.description)
                            }) {
                                Text(item.title)
                                    .font(.system(size: 20, weight: .bold, design: .default))
                                    .frame(width: 100, height: 50)
                                    .background(selectedTask == item.id ? Color.black.opacity(0.5) : Color.white.opacity(0.5))
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
            .frame(width: 370, height: 150)
            .background(Color.black.opacity(0.1))
            .cornerRadius(20)
            .padding()
        
            
            
            // 하단
            HStack(){
               
                ForEach(4..<7, id: \.self) {index in
                    if(index < taskCreateModel.selectedDay ?? 7){
                        Button(action: {
                            
                        }) {
                            Text(taskCreateModel.weekdays[index])
                                .font(.system(size: 20, weight: .bold, design: .default))
                                .frame(width: 80, height: 150, alignment: .top)
                                .background(Color(hex: "E9EAF0"))
                                .cornerRadius(20)
                                .foregroundColor({
                                    switch taskCreateModel.weekdays[index] {
                                    case "Sun":
                                        return .red
                                    case "Sat":
                                        return .blue
                                    default:
                                        return .black
                                    }
                                }())
                            
                        }
                    }
                }
                    
            }
            .frame(width: 370, height: 200)
            .background(Color.black.opacity(0.1))
            .cornerRadius(20)
            .padding()
         
        }
        .padding(.bottom, 70)
    }
}

#Preview {
    var taskCreateModel: TaskCreateModel = TaskCreateModel()
    TaskStep3(taskCreateModel: taskCreateModel)
}
