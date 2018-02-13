//
//  Todo.swift
//  GrokRESTAPI
//
//  Created by Michael Vilabrera on 2/13/18.
//  Copyright © 2018 Michael Vilabrera. All rights reserved.
//

import Foundation

class Todo {
    var title: String
    var id: Int?
    var userId: Int
    var completed: Bool
    
    required init?(title: String, id: Int?, userId: Int, completedStatus: Bool) {
        self.title = title
        self.id = id
        self.userId = userId
        self.completed = completedStatus
    }
    
    func description() -> String {
        return "ID: \(String(describing: id))," +
            "User ID: \(userId)\n" +
            "Title: \(title)\n" +
        "Completed? \(completed)"
    }
}
