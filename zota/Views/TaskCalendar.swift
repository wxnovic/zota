//
//  Untitled.swift
//  zota
//
//  Created by 예나 on 4/25/25.
//

import SwiftUI

// 📦 요일 박스 뷰
struct DayTaskBox: View {
    let day: String

    // 🔁 나중에 Date로 오늘 요일 구분하는 로직 추가 예정
    let today = "Mon" // TODO: 오늘 요일을 Date 기반으로 계산해서 대체하기

    var body: some View {
        VStack {
            Text(day)
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(day == today ? Color(hex: "BF2E14") : Color(hex: "005B00"))
                .padding(.top, 10)

            Spacer()
        }
        .frame(width: 80, height: 130)
        .background(Color(hex: "E9EAF0"))
        .cornerRadius(24)
        .shadow(color: Color(hex: "BDC8DF").opacity(0.7), radius: 12, x: 6, y: 6)
        .shadow(color: Color.white.opacity(0.7), radius: 12, x: -6, y: -6)
    }
}

// 🌈 메인 배경 뷰
struct TaskCalendar: View {
    let days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]

    var body: some View {
        ZStack {
            // 🌤 하늘 배경
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            // ☁️ 구름 2개
            VStack {
                HStack {
                    Image("cloud")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 40)
                        .offset(x: -20, y: 250)

                    Spacer()

                    Image("cloud")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 40)
                        .offset(x: 30, y: 150)
                }
                Spacer()
            }
            .padding()

            // 🧱 주간 배경 이미지
            VStack {
                Spacer()
                Image("weekbackground")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .ignoresSafeArea(edges: .bottom)
            }

            // 📅 요일 박스들 (4 + 3)
            VStack {
                let topRow = days.prefix(4)
                let bottomRow = days.suffix(3)

                VStack(spacing: 40) {
                    HStack(spacing: 20) {
                        ForEach(topRow, id: \.self) { day in
                            DayTaskBox(day: day)
                        }
                    }

                    HStack(spacing: 30) {
                        ForEach(bottomRow, id: \.self) { day in
                            DayTaskBox(day: day)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .offset(y: 170)
            }
        }
    }
}

// 🔍 프리뷰
#Preview {
    TaskCalendar()
}
