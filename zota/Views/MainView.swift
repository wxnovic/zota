import SwiftUI

struct MainView: View {
    
    @State private var sunOffset: CGFloat = 0
    @State private var cloudOffset1: CGFloat = 0
    @State private var cloudOffset2: CGFloat = 0
    @State private var cloudOffset3: CGFloat = 0
    @State private var cloudOffset4: CGFloat = 0
    @State private var bombVerticalOffset: CGFloat = 0  // bomb ZStack의 수직 오프셋

    var body: some View {
        GeometryReader { geometry in
            let width: CGFloat = geometry.size.width
            let height: CGFloat = geometry.size.height

            ZStack {
                Image("background")
                    .resizable()
                    .ignoresSafeArea()
                    .zIndex(-1)

                Image("sun")
                    .offset(x: sunOffset)
                    .position(x: width * 0.3, y: height * 0.1)
                    .zIndex(1)

                Image("cloud")
                    .offset(x: cloudOffset1)
                    .position(x: width * 0.15, y: height * 0.09)
                    .opacity(0.9)
                    .zIndex(2)

                Image("cloud")
                    .offset(x: cloudOffset2)
                    .position(x: width * 0.8, y: height * 0.38)
                    .zIndex(0)

                Image("cloud")
                    .offset(x: cloudOffset3)
                    .position(x: width * 0.15, y: height * 0.65)
                    .zIndex(0)

                Image("cloud")
                    .offset(x: cloudOffset4)
                    .position(x: width * 0.9, y: height * 0.95)
                    .zIndex(0)

                VStack {
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
                    .offset(y: bombVerticalOffset)  // 수직 애니메이션 적용

                    VStack {
                        HStack {
                            Text("04/22")
                                .font(.title)
                                .bold()
                            Text("Tue")
                                .foregroundColor(.green)
                                .font(.title)
                                .bold()
                        }
                    }

                    VStack {
                        HStack {
                            ZStack {
                                VStack {
                                    HStack {
                                        TaskPaper(text: "밥 먹기")
                                        TaskPaper(text: "발표준비")
                                    }
                                    HStack {
                                        TaskPaper(text: "뭐라고?")
                                        TaskPaper(text: "폭탄 터뜨리기")
                                    }
                                }
                            }
                        }
                    }
                    .frame(width: 300, height: 400)
                    .background(Color.gray.opacity(0.8), in: RoundedRectangle(cornerRadius: 25))
                }
                .position(x: width / 2, y: height / 2)
            }
            .onAppear {
                animateElements()
            }
        }
    }

    func animateElements() {
        withAnimation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
            sunOffset = 10
            cloudOffset1 = -10
            cloudOffset2 = 8
            cloudOffset3 = -6
            cloudOffset4 = 10
            bombVerticalOffset = -20  // 위로 살짝 이동 (반복적으로)
        }
    }
}

#Preview {
    MainView()
}
