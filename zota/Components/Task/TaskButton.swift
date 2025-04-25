//
//  TaskButton.swift
//  zota
//
//  Created by Aaron on 4/25/25.
//

import SwiftUI

struct TaskButton: View {
    let title: String
    var isEditMode: Bool
    var isPlus: Bool = false
    var isSelected: Bool = false
    var onDelete: () -> Void
    var onTap: () -> Void
    var onLongPress: () -> Void

    @GestureState private var isPressed = false
    @State private var isWiggling = false

    var body: some View {
        ZStack(alignment: .topTrailing) {
            ZStack {
                // ✅ 반투명 박스 + 선택 시 연파란색 배경 오버레이
                RoundedRectangle(cornerRadius: 25)
                    .fill(.ultraThinMaterial)
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(isSelected ? Color.blue.opacity(0.45) : .clear)
                            .animation(.easeInOut(duration: 0.25), value: isSelected)
                    )
                    .frame(width: 85, height: 50)
                    .scaleEffect(isPressed ? 0.94 : 1.0)
                    .shadow(color: isPressed ? .black.opacity(0.3) : .black.opacity(0.1), radius: 4, x: 0, y: 3)
                    .blur(radius: isPressed ? 0.5 : 0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.white.opacity(0.2), lineWidth: 1)
                    )

                if isPlus {
                    Image(systemName: "plus")
                        .font(.title2)
                        .foregroundColor(.blue)
                } else {
                    // ✅ 선택 시 텍스트는 흰색으로 자연스럽게 변화
                    Text(title)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(isSelected ? .white : .black)
                        .animation(.easeInOut(duration: 0.25), value: isSelected)
                        .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 1)
                        .padding(.horizontal, 2)
                }
            }
            // ✅ 기본/길게 누르기 제스처
            .gesture(
                LongPressGesture(minimumDuration: 0.5)
                    .updating($isPressed) { current, state, _ in
                        state = current
                    }
                    .onEnded { _ in
                        onLongPress()
                    }
            )
            .simultaneousGesture(
                TapGesture()
                    .onEnded {
                        if !isEditMode {
                            onTap()
                        }
                    }
            )
            .rotationEffect(.degrees(isEditMode && isWiggling ? -2 : 0))
            .animation(
                isEditMode
                    ? .linear(duration: 0.15).repeatForever(autoreverses: true)
                    : .default,
                value: isWiggling
            )
            .onChange(of: isEditMode) { active in
                isWiggling = active
            }

            // ✅ 삭제 버튼 (edit 모드 시만 표시)
            if isEditMode && !isPlus {
                Button(action: onDelete) {
                    Image(systemName: "xmark")
                        .font(.system(size: 12, weight: .bold))       // X 아이콘 크기 축소
                        .foregroundColor(.white)
                        .frame(width: 15, height: 15)                 // 전체 버튼 크기 축소
                        .background(Circle().fill(Color.red))
                        .shadow(radius: 1)
                }
                .offset(x: 10, y: -10)
            }

        }
    }
}

