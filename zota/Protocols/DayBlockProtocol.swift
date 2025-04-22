//
//  DayProtocol.swift
//  zota
//
//  Created by emdas93 on 4/22/25.
//

import CoreData

protocol DayBlockProtocol {
    var id: UUID { get }            // ID 값
    var title: String { get }       // 데이 제목
    var description: String? { get }
    var dayCounts: Int { get }      // 데이 일수 (1일 ~ 7일)
    var createdAt: Date { get }     // 만들어진 날짜
    var updatedAt: Date { get }     // 수정된 날짜

}

