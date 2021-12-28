//
//  Task.swift
//  ToDoTaskForExam
//
//  Created by Zokirov Firdavs on 30/04/21.
//

import UIKit




enum TaskState: Int, Codable {
    case new
    case finished
    case archived
}

struct Task : Codable{
    var date: String
    var title: String
    var description: String
    var priority: TaskPriority
    var state: TaskState = .new
    var subtasks: [SubTask]
}

