import SwiftUI

struct TaskPaper: View {

    var onDone: (() -> Void)?
    
    @Bindable var task:TaskModel


    @State private var dragOffset: CGSize = .zero

    @State private var showCheck = false
    @State private var checkScale: CGFloat = 0.6
    @State private var checkOpacity: Double = 0

    @State private var showCountText = false
    @State private var countOffset: CGFloat = 10
    @State private var countOpacity: Double = 0

    var body: some View {
        ZStack {
            if showCheck {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.green)
                    .scaleEffect(checkScale)
                    .opacity(checkOpacity)
                    .transition(.scale.combined(with: .opacity))
                    .zIndex(3)
            }

            if task.isDone {
                Text(task.password.description)
                    .font(.title)
                    .foregroundColor(.orange)
                    .bold()
                    
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .zIndex(2)
            }

            if !task.isDone {
                ZStack {
                    Rectangle()
                        .frame(width: 120, height: 140)
                        .foregroundColor(Color(hex: "DDDDDD"))
                        .cornerRadius(10)

                    Rectangle()
                        .frame(width: 95, height: 120)
                        .foregroundColor(Color(hex: "D9D9D9"))
                        .cornerRadius(15)

                    Image("tear-line")
                        .resizable()
                        .frame(width: 95, height: 10)
                        .offset(x: 0, y: -30)

                    Image("paper")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .offset(
                            x: task.isDone ? -30 : 0,
                            y: task.isDone ? 60 : 15
                        )
                        .rotationEffect(
                            task.isDone
                            ? Angle(degrees: -30)
                            : Angle(degrees: Double(dragOffset.height) / 5),
                            anchor: .topLeading
                        )
                        .opacity(task.isDone ? 0 : 1)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    if value.translation.width < 0 {
                                        dragOffset = value.translation
                                    }
                                }
                                .onEnded { value in
                                    if value.translation.width < 0 && abs(value.translation.height) > 80 {
                                        withAnimation(.easeInOut(duration: 0.3)) {
                                            task.isDone = true
                                        }
                                        
                                        onDone?()

                                        // ✅ 체크 등장
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                            withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                                                showCheck = true
                                                checkScale = 1.0
                                                checkOpacity = 1.0
                                            }
                                        }

                                        // ✅ 체크 사라짐 후 숫자 등장
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
                                            withAnimation(.easeOut(duration: 0.3)) {
                                                showCheck = false
                                            }

                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                                withAnimation(.easeOut(duration: 0.6)) {
                                                    showCountText = true
                                                    countOffset = -20
                                                    countOpacity = 1.0
                                                }
                                            }
                                        }
                                    } else {
                                        withAnimation(.spring()) {
                                            dragOffset = .zero
                                        }
                                    }
                                }
                        )
                        .zIndex(1)

                    Text(task.title.description)
                        .frame(width: 80, height: 120)
                        .foregroundColor(.black)
                        .font(.title3)
                        .offset(
                            x: task.isDone ? -20 : 0,
                            y: task.isDone ? 55 : 10
                        )
                        .rotationEffect(
                            task.isDone
                            ? Angle(degrees: -30)
                            : Angle(degrees: Double(dragOffset.height) / 5),
                            anchor: .topLeading
                        )
                        .opacity(task.isDone ? 0 : 1)
                        .zIndex(2)
                }
                .animation(.spring(), value: dragOffset)
                .animation(.easeInOut(duration: 0.3), value: task.isDone)
            }
        }
        .frame(width: 120, height: 140)
    }
}
