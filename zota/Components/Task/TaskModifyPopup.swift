//
//  Untitled.swift
//  zota
//
//  Created by 윤 on 4/25/25.
//

import SwiftUI

struct TaskModifyPopup: View {
    // 📅 오늘 날짜 자동 포맷용 formatter
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd"
        return formatter
    }()

    let dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE" // 요일 (Mon, Tue, ...)
        return formatter
    }()

    var body: some View {
        VStack {
            ZStack {
                // 🟨 배경 사각형
                Rectangle()
                    .fill(Color.init(hex:"E9EAF0"))
                    .frame(width: 300, height: 550)
                    .cornerRadius(30)
                    .padding(.top, 75)

                // 📦 내부 내용 (날짜 & 버튼 포함)
                VStack {
                    HStack {
                        // 왼쪽: 날짜 & 요일
                        VStack(alignment: .leading) {
                            Text(dateFormatter.string(from: Date()))
                                .font(.title3)
                                .foregroundColor(.black)
                            Text(dayFormatter.string(from: Date()).uppercased())
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }

                        Spacer()

                        // 오른쪽: X 버튼
                        Button(action: {
                            // 닫기 액션
                        }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .padding(8)
                                .background(Color.white.opacity(0.8))
                                .clipShape(Circle())
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 50) // ✅ 더 아래로 내리기

                    Spacer()
                }
                .frame(width: 300, height: 550)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    TaskModifyPopup()
}
