//
//  TaskProtocol.swift
//  zota
//
//  Created by emdas93 on 4/22/25.
//

import CoreData

protocol TaskProtocol {
    var id: UUID { get }            // ID 값
    var title: String { get }       // 태스크 제목
    var description: String? { get }
    var isCompleted: Bool { get }   // 완료 여부
    var createdAt: Date { get }     // 만들어진 날짜
    var updatedAt: Date { get }     // 수정된 날짜
    var priority: Int16 { get }     // 우선순위 (정렬)
    var note: String? { get }       // 노트?
    var dayBlock: UUID { get }           // 속한 데이
    
    func toggleCompleted()
}


