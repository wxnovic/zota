//
//  TaskAddStep1.swift
//  zota
//
//  Created by Bryan on 4/25/25.
//
import SwiftUI

struct TaskAddStep3: View {
    @State private var isEditMode: Bool = false
    @State private var isAddingTask: Bool = false

    var body: some View {
        ZStack {
            BackgroundView()
                .onTapGesture {
                    isEditMode = false
                    isAddingTask = false
                }
            VStack(spacing: 0) {
                BackButtonView()
                Spacer().frame(height: 12)
                TopDaySectionView()
                Spacer().frame(height: 24)
                TaskScrollBoxView(isEditMode: $isEditMode, isAddingTask: $isAddingTask)
                Spacer().frame(height: 36)
                BottomDaySectionView()
                Spacer()
                OkButtonView()
            }
        }
    }
}

// MARK: - Background
struct BackgroundView: View {
    var body: some View {
        Image("BackgroundLandscape")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
    }
}

// MARK: - Back Button
struct BackButtonView: View {
    var body: some View {
        HStack {
            Button(action: {}) {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(.black)
                    .padding(12)
                    .background(Color.white.opacity(0.8))
                    .clipShape(Circle())
            }
            Spacer()
        }
        .padding(.leading, 16)
        .padding(.top, 16)
    }
}

// MARK: - Top Days
struct TopDaySectionView: View {
    let daysTop = ["Mon", "Tue", "Wed", "Thu"]

    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
                .frame(width: 381, height: 164)
                .overlay(
                    HStack(spacing: 16) {
                        ForEach(daysTop, id: \.self) { day in
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.white.opacity(0.9))
                                .frame(width: 80, height: 140)
                                .overlay(
                                    Text(day)
                                        .fontWeight(.semibold)
                                        .foregroundColor(day == "Mon" ? .red : .green)
                                )
                        }
                    }
                )
        }
    }
}

// MARK: - Bottom Days
struct BottomDaySectionView: View {
    let daysBottom = ["Fri", "Sat", "Sun"]

    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
                .frame(width: 381, height: 164)
                .overlay(
                    HStack(spacing: 16) {
                        ForEach(daysBottom, id: \.self) { day in
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.white.opacity(0.9))
                                .frame(width: 80, height: 140)
                                .overlay(
                                    Text(day)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.green)
                                )
                        }
                    }
                )
        }
    }
}

// MARK: - Task Scroll Box
struct TaskScrollBoxView: View {
    @State private var tasks: [String] = ["자료조사", "개요작성", "PPT제작", "대본작성"]
    @State private var newTask: String = ""
    @Binding var isEditMode: Bool
    @Binding var isAddingTask: Bool

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
                .frame(width: 381, height: 198)

            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .center, spacing: 16) {
                    Spacer().frame(height: 16)
                    ForEach(taskLinesWithPlus(), id: \.self) { line in
                        HStack(spacing: 16) {
                            ForEach(line, id: \.self) { task in
                                if task == "+PLACEHOLDER+" {
                                    if isAddingTask {
                                        TextField("", text: $newTask)
                                            .font(.subheadline)
                                            .foregroundColor(.black)
                                            .frame(width: 96, height: 51)
                                            .padding(.horizontal, 12)
                                            .background(
                                                Capsule()
                                                    .fill(Color.white)
                                                    .shadow(radius: 2)
                                            )
                                            .submitLabel(.done)
                                            .onSubmit {
                                                if !newTask.isEmpty {
                                                    tasks.append(newTask)
                                                    newTask = ""
                                                    isAddingTask = false
                                                }
                                            }
                                    } else {
                                        TaskButtonView(
                                            title: "",
                                            isEditMode: isEditMode,
                                            isPlus: true,
                                            onDelete: {},
                                            onTap: {
                                                isAddingTask = true
                                            },
                                            onLongPress: {}
                                        )
                                    }
                                } else {
                                    TaskButtonView(
                                        title: task,
                                        isEditMode: isEditMode,
                                        isPlus: false,
                                        onDelete: {
                                            tasks.removeAll { $0 == task }
                                        },
                                        onTap: {},
                                        onLongPress: {
                                            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                                            isEditMode = true
                                        }
                                    )
                                }
                            }
                        }
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 24)
                .padding(.vertical, 8)
            }
            .frame(width: 381, height: 198)
        }
    }

    private func taskLinesWithPlus() -> [[String]] {
        var result: [[String]] = []
        var currentLine: [String] = []

        for (i, task) in tasks.enumerated() {
            currentLine.append(task)
            if currentLine.count == 3 || i == tasks.count - 1 {
                result.append(currentLine)
                currentLine = []
            }
        }

        if let last = result.last, last.count < 3 {
            result[result.count - 1].append("+PLACEHOLDER+")
        } else {
            result.append(["+PLACEHOLDER+"])
        }

        return result
    }
}

// MARK: - OK Button
struct OkButtonView: View {
    var body: some View {
        HStack {
            Spacer()
            Button(action: {}) {
                Text("OK")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .frame(width: 300, height: 77)
                    .background(
                        RoundedRectangle(cornerRadius: 40)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color(red: 0.6, green: 0.85, blue: 0.75), Color(red: 0.35, green: 0.65, blue: 0.55)]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .shadow(radius: 4)
                    )
            }
            Spacer()
        }
        .padding(.bottom, 30)
    }
}

// MARK: - Task Button
struct TaskButtonView: View {
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
                RoundedRectangle(cornerRadius: 25)
                    .fill(.ultraThinMaterial)
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(isSelected ? Color.blue.opacity(0.45) : .clear)
                            .animation(.easeInOut(duration: 0.25), value: isSelected)
                    )
                    .frame(width: 96, height: 51)
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
                    Text(title)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(isSelected ? .white : .black)
                        .animation(.easeInOut(duration: 0.25), value: isSelected)
                        .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 1)
                        .padding(.horizontal, 2)
                }
            }
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

            if isEditMode && !isPlus {
                Button(action: onDelete) {
                    Image(systemName: "xmark")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 15, height: 15)
                        .background(Circle().fill(Color.red))
                        .shadow(radius: 1)
                }
                .offset(x: 10, y: -10)
            }
        }
    }
}


#Preview {
    TaskAddStep3()
}
