import SwiftUI

struct TaskPaper: View {
    var text: String

    @State private var dragOffset: CGSize = .zero
    @State private var isDone: Bool = false

    var body: some View {
        if isDone {
            EmptyView()
        } else {
            ZStack {
                // 바깥쪽 회색 배경 (그림자용)
                Rectangle()
                    .frame(width: 120, height: 140)
                    .foregroundColor(Color(hex: "DDDDDD"))
                    .cornerRadius(10)

                // 안쪽 종이 배경
                Rectangle()
                    .frame(width: 95, height: 120)
                    .foregroundColor(Color(hex: "D9D9D9"))
                    .cornerRadius(15)

                // 찢는 선
                Image("tear-line")
                    .resizable()
                    .frame(width: 95, height: 10)
                    .offset(x: 0, y: -30)

                // 종이 이미지
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
                                // 왼쪽으로 드래그할 때만 반응
                                if value.translation.width < 0 {
                                    dragOffset = value.translation
                                }
                            }
                            .onEnded { value in
                                if value.translation.width < 0 && abs(value.translation.height) > 80 {
                                    withAnimation(.easeInOut(duration: 0.3)) {
                                        isDone = true
                                    }
                                } else {
                                    withAnimation(.spring()) {
                                        dragOffset = .zero
                                    }
                                }
                            }
                    )
                    .zIndex(1)

                // 텍스트
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
}

// 미리보기
#Preview {
    TaskPaper(text: "TEST")
}
