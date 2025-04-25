import SwiftUI

struct TaskPaper: View {
    var id: Int
    var text: String


    @State private var dragOffset: CGSize = .zero
    @State private var isDone: Bool = false

    @State private var showCheck = false
    @State private var checkScale: CGFloat = 0.6
    @State private var checkOpacity: Double = 0

    @State private var showCountText = false
    @State private var countOffset: CGFloat = 10
    @State private var countOpacity: Double = 0

    var body: some View {
        ZStack {
            // ✅ 체크 아이콘
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

            // ✅ 숫자 등장
            if showCountText {
                Text("5")
                    .font(.title)
                    .foregroundColor(.orange)
                    .bold()
                    .offset(y: countOffset)
                    .opacity(countOpacity)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .zIndex(4)
            }

            if !isDone {
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
                            x: isDone ? -30 : 0,
                            y: isDone ? 60 : 15
                        )
                        .rotationEffect(
                            isDone
                            ? Angle(degrees: -30)
                            : Angle(degrees: Double(dragOffset.height) / 5),
                            anchor: .topLeading
                        )
                        .opacity(isDone ? 0 : 1)
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
                                            isDone = true
                                        }

                                        // ✅ 햅틱 + 체크 등장
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                            let generator = UINotificationFeedbackGenerator()
                                            generator.notificationOccurred(.success)

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

                    Text(text)
                        .frame(width: 80, height: 120)
                        .foregroundColor(.black)
                        .font(.title3)
                        .offset(
                            x: isDone ? -20 : 0,
                            y: isDone ? 55 : 10
                        )
                        .rotationEffect(
                            isDone
                            ? Angle(degrees: -30)
                            : Angle(degrees: Double(dragOffset.height) / 5),
                            anchor: .topLeading
                        )
                        .opacity(isDone ? 0 : 1)
                        .zIndex(2)
                }
                .animation(.spring(), value: dragOffset)
                .animation(.easeInOut(duration: 0.3), value: isDone)
            }
        }
        .frame(width: 120, height: 140)
    }
}

#Preview {
    TaskPaper(id: 1, text: "TET")
}
