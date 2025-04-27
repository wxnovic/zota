    import SwiftUI
    import SwiftData

    struct TaskMainView: View {
        @Environment(\.modelContext) private var context
        
        @Query var tasks: [TaskModel]
        
        @State private var showCloud1 = false
        @State private var showCloud2 = false
        @State private var showCloud3 = false
        @State private var showCloud4 = false
        @State private var showSun = false
        @State private var showBomb = false
        @State private var showTasks = false

        @State private var bombVerticalOffset: CGFloat = 0

        var body: some View {
            GeometryReader { geometry in
                let width = geometry.size.width
                let height = geometry.size.height

                ZStack {
                    Image("background")
                        .resizable()
                        .ignoresSafeArea()

                    if showSun {
                        Image("sun")
                            .transition(.opacity)
                            .position(x: width * 0.3, y: height * 0.1)
                            .zIndex(1)
                    }

                    if showCloud1 {
                        Image("cloud")
                            .transition(.opacity)
                            .position(x: width * 0.15, y: height * 0.09)
                            .opacity(0.9)
                            .zIndex(2)
                    }

                    if showCloud2 {
                        Image("cloud")
                            .transition(.opacity)
                            .position(x: width * 0.8, y: height * 0.38)
                            .zIndex(0)
                    }

                    if showCloud3 {
                        Image("cloud")
                            .transition(.opacity)
                            .position(x: width * 0.15, y: height * 0.65)
                            .zIndex(0)
                    }

                    if showCloud4 {
                        Image("cloud")
                            .transition(.opacity)
                            .position(x: width * 0.9, y: height * 0.95)
                            .zIndex(0)
                    }

                    if showBomb || showTasks {
                        VStack {
                            if showBomb {
                                ZStack {
                                    Image("bomb")
                                        .resizable()
                                        .frame(width: 300, height: 300)

                                    Text("04 : 04")
                                        .foregroundColor(.red)
                                        .zIndex(1)
                                        .font(.title)
                                        .offset(x: 2, y: 16)
                                }
                                .padding()
                                .shadow(radius: 10)
                                .frame(width: 300, height: 250)
                                .offset(y: bombVerticalOffset)
                                .transition(.scale)
                            }

                            if showTasks {
                                VStack {
                                    VStack {
                                        HStack {
                                            Text("04/22")
                                                .foregroundColor(.green)
                                                .font(.title)
                                                .shadow(radius: 2)
                                                .bold()
                                            Text("Tue")
                                                .foregroundColor(.green)
                                                .font(.title)
                                                .shadow(radius: 2)
                                                .bold()
                                                .onTapGesture {
                                                    print(tasks[0].password)
                                                }
                                        }
                                    }
                                    HStack {
                                        ScrollView {
                                            VStack(spacing: 16) { // 줄 간격
                                                ForEach(tasks.chunked(into: 2), id: \.self) { taskRow in
                                                    HStack(spacing: 16) { // 한 줄에 2개
                                                        ForEach(taskRow, id: \.id) { task in
                                                            TaskPaper(task:task)
                                                        }
                                                    }
                                                }
                                            }
                                            .padding()
                                        }
                                    }

                                }
                                .frame(width: 300, height: 400)
                                .background(Color.gray.opacity(0.2), in: RoundedRectangle(cornerRadius: 25))
                                .transition(.opacity.combined(with: .scale))
                            }
                        }
                        .position(x: width / 2, y: height / 2)
                    }
                }
                .onAppear {
                    
                    showInSequence()
                }
            }
        }

        func showInSequence() {
            // 순차적으로 나타나는 효과
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { withAnimation { showCloud1 = true } }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { withAnimation { showCloud2 = true } }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) { withAnimation { showCloud3 = true } }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) { withAnimation { showCloud4 = true } }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) { withAnimation { showSun = true } }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { withAnimation { showBomb = true } }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.4) {
                withAnimation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                    bombVerticalOffset = -20
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.8) { withAnimation { showTasks = true } }
        }
        
        func setIsDone(_ id: Int64) {
            guard let index = tasks.firstIndex(where: { $0.id == id }) else { return }
            tasks[index].isDone = true

            // 변경 사항 저장
            try? context.save()
        }


        
    }

    #Preview {
        TaskMainView()
    }
