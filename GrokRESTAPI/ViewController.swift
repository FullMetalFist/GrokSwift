//
//  ViewController.swift
//  GrokRESTAPI
//
//  Created by Michael Vilabrera on 1/5/18.
//  Copyright © 2018 Michael Vilabrera. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Todo.todoByID(id: 1) { result in
            if let error = result.error {
                print("error calling POST on /todos/")
                print(error)
                return
            }
            guard let todo = result.value else {
                print("error calling POST on /todos/, result is nil")
                return
            }
            
            print(todo.description())
            print(todo.title)
        }
        
        guard let newTodo = Todo(title: "First todo", id: nil, userId: 1, completedStatus: true) else {
            print("error: newTodo isn't a Todo")
            return
        }
        
        newTodo.save { result in
            guard result.error == nil else {
                print("error calling POST on /todos/")
                print(result.error)
                return
            }
            guard let todo = result.value else {
                print("error calling POST on /todos/, result is nil")
                return
            }
            print(todo.description())
            print(todo.title)
        }
    }
    
    func getRequestAlamo() {
        Alamofire.request(TodoRouter.get(1)).responseJSON { response in
            
            guard response.result.error == nil else {
                print("error calling GET on /todos/1")
                print(response.result.error!)
                return
            }
            
            guard let json = response.result.value as? [String: Any] else {
                print("didn't get todo object as JSON from API")
                print("Error: \(String(describing: response.result.error))")
                return
            }
            
            guard let todoTitle = json["title"] as? String else {
                print("could not get todo title from JSON")
                return
            }
            print("the title is: " + todoTitle)
        }
    }
    
    func postRequestAlamo() {
        
        let newTodo: [String: Any] = ["title": "First Alamo Post", "completed": 0, "userId": 1]
        Alamofire.request(TodoRouter.create(newTodo)).responseJSON { response in
            
            guard response.result.error == nil else {
                print("error calling POST on /todos/1")
                print(response.result.error!)
                return
            }
            
            guard let json = response.result.value as? [String: Any] else {
                print("didn't get todo object as JSON from API")
                print("Error: \(String(describing: response.result.error))")
                return
            }
            guard let todoTitle = json["title"] as? String else {
                print("could not get todo title")
                return
            }
            print("the title is: \(todoTitle)")
        }
    }
    
    func deleteRequestAlamo() {
        
        Alamofire.request(TodoRouter.delete(1)).responseJSON { response in
            guard response.result.error == nil else {
                print("error calling DELETE on /todos/1")
                print(response.result.error!)
                return
            }
            print("DELETE ok")
        }
    }
}

