import SwiftUI
import SwiftData

class TaskData: ObservableObject, CustomStringConvertible {
    var description: String = ""
    
    @Published var title: String = ""
    @Published var categoryId: Int64 = 0
    @Published var date: String = ""
}

class TaskCreateModel: ObservableObject {
    
    
    // View 관련 상태
    @Published var step: Int = 1
    
    // 유저가 선택한 카테고리
    var selectedCategoryId: Int64?
    
    // Days가 가질 taskData
    @Published var taskDatas: [TaskData] = []
    
    
    // 유저가 선택한 일수
    @Published var selectedDay: Int?
    
    
    var today: Date = Date()
    var dates: [String] {
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"
        
        return (0..<7).compactMap { offset in
            guard let date = calendar.date(byAdding: .day, value: offset, to: today) else {
                return nil
            }
            return formatter.string(from: date)
        }
    }
    
    var weekdays: [String] {
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX") // 월요일(Mon), 화요일(Tue) 영문으로
        formatter.dateFormat = "EEE" // 요일만 짧게 (Mon, Tue 등)
        
        return (0..<7).compactMap { offset in
            guard let date = calendar.date(byAdding: .day, value: offset, to: today) else {
                return nil
            }
            return formatter.string(from: date)
        }
    }
    
    
}


struct TaskCreateView: View {
    
    
    @StateObject private var taskCreateModel: TaskCreateModel = TaskCreateModel()
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ZStack {
            Image("wallpaper")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .onTapGesture {
                    print()
                }
                .zIndex(-1)
            
            if taskCreateModel.step == 1 {
                TaskStep1(taskCreateModel: taskCreateModel)
                    .transition(.move(edge: .leading)) // 👉 이동 효과 추가
            }
            else if taskCreateModel.step == 2 {
                TaskStep2(taskCreateModel: taskCreateModel)
                    .transition(.move(edge: .leading))
            }
            else if taskCreateModel.step == 3 {
                TaskStep3(taskCreateModel: taskCreateModel)
                    .transition(.move(edge: .leading))
            }
            
            VStack {
                Spacer()
                
                HStack {
                    Button(action: {
                        withAnimation {
                            taskCreateModel.step = max(taskCreateModel.step - 1, 1)
                        }
                        print(taskCreateModel.step)
                    }) {
                        Text("이전")
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .frame(width: 80, height: 50)
                            .background(Color.white.opacity(0.5))
                            .cornerRadius(20)
                            .foregroundStyle(.black)
                    }
                    Spacer()
                    Button(action: {
                        withAnimation {
                            
                            // 첫번째 화면에서 넘어갈때 validation
                            if(taskCreateModel.step == 1 && (taskCreateModel.selectedCategoryId) != nil){
                                taskCreateModel.step = min(taskCreateModel.step + 1, 3)
                            }
                            
                            // 두번째 화면에서 넘어갈때 validation
                            else if(taskCreateModel.step == 2 && (taskCreateModel.selectedDay != nil)){
                                taskCreateModel.step = min(taskCreateModel.step + 1, 3)
                                if let selectedDay = taskCreateModel.selectedDay {
                                        taskCreateModel.taskDatas.removeAll()
                                        for _ in 0..<selectedDay {
                                            taskCreateModel.taskDatas.append(TaskData())
                                        }
                                    }
                            }
                            
                            // 세번째 화면 완료 작업 작성
                            else if(taskCreateModel.step == 3){
                                // 완료 작업 작성
                                print(taskCreateModel)
                                

                            }
                            
                        }
                        print(taskCreateModel.step)
                    }) {
                        Text(taskCreateModel.step == 3 ? "완료" : "다음")
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .frame(width: 80, height: 50)
                            .background(Color.white.opacity(0.5))
                            .cornerRadius(20)
                            .foregroundStyle(.black)
                    }
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 80)
            }
        }
    }
}

#Preview {
    TaskCreateView()
}
