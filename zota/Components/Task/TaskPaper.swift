import SwiftUI

struct TaskPaper: View {
    var text: String

    // 드래그 위치 상태
    @State private var dragOffset: CGSize = .zero

    // 찢어졌는지 여부 (true면 사라짐)
    @State private var isDone: Bool = false

    // 드래그 방향을 왼쪽 또는 오른쪽으로 추적
    @State private var dragDirection: DragSide = .left

    // 왼쪽 or 오른쪽 드래그를 구분하기 위한 enum
    enum DragSide {
        case left, right
    }

    var body: some View {
        // 찢어진 상태이면 아무것도 안 보여줌
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
                
                // 찢어질 위치를 시각적으로 보여주는 선
                Image("tear-line")
                    .resizable()
                    .frame(width: 95, height: 10)
                    .offset(x: 0, y: -30)

                // 메인 종이 이미지
                Image("paper")
                    .resizable()
                    .frame(width: 100, height: 100)
                    // 찢어졌을 때는 왼쪽 또는 오른쪽으로 이동하면서 아래로 떨어지는 듯한 효과
                    .offset(
                        x: isDone ? (dragDirection == .left ? -30 : 30) : 0,
                        y: isDone ? 60 : 15
                    )
                    // 회전 효과: 드래그 중엔 약간 흔들림, 찢어질 땐 왼쪽 또는 오른쪽 위 모서리를 기준으로 회전
                    .rotationEffect(
                        isDone
                        ? Angle(degrees: dragDirection == .left ? -30 : 30)
                        : Angle(degrees: Double(dragOffset.height) / 10),
                        anchor: dragDirection == .left ? .topLeading : .bottomLeading
                    )
                    // 찢어지면 투명하게 사라짐
                    .opacity(isDone ? 0 : 1)
                    // 드래그 제스처 처리
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                dragOffset = value.translation
                                // 현재 드래그 방향 저장
                                dragDirection = value.translation.width < 0 ? .left : .right
                            }
                            .onEnded { value in
                                // 수직으로 80pt 이상 드래그하면 찢어진 것으로 간주
                                if abs(value.translation.height) > 80 {
                                    withAnimation(.easeInOut(duration: 0.3)) {
                                        isDone = true
                                    }
                                } else {
                                    // 찢어질 정도가 아니면 원래 위치로 되돌림
                                    withAnimation(.spring()) {
                                        dragOffset = .zero
                                    }
                                }
                            }
                    )
                    .zIndex(1) // 텍스트보다 뒤에 있어야 함
                
                // 텍스트 (종이 위에 적혀 있는 내용)
                Text(text)
                    .frame(width: 80, height: 120)
                    .foregroundColor(.black)
                    .font(.title3)
                    // 찢어질 때 방향 따라 이동, 아니면 고정 위치
                    .offset(
                        x: isDone ? (dragDirection == .left ? -20 : 20) : 0,
                        y: isDone ? 55 : 10
                    )
                    // 회전 효과: 이미지와 동일하게 적용
                    .rotationEffect(
                        isDone
                        ? Angle(degrees: dragDirection == .left ? -30 : 30)
                        : Angle(degrees: Double(dragOffset.height) / 12),
                        anchor: dragDirection == .left ? .topLeading : .topTrailing
                    )
                    .opacity(isDone ? 0 : 1)
                    .zIndex(2) // 텍스트는 종이 이미지 위에 표시됨
            }
            // 드래그 중엔 spring 애니메이션 적용
            .animation(.spring(), value: dragOffset)
            // 찢어질 때는 부드러운 easeInOut 애니메이션
            .animation(.easeInOut(duration: 0.3), value: isDone)
        }
    }
}

// 미리보기
#Preview {
    TaskPaper(text: "TEST")
}
