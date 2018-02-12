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
        request3()
    }
    
    func request3() {
        // DELETE
        let todoEndpoint = "https://jsonplaceholder.typicode.com/todos/1"
        
        guard let todoURL = URL(string: todoEndpoint) else {
            print("no URL")
            return
        }
        
        var todoURLRequest = URLRequest(url: todoURL)
        todoURLRequest.httpMethod = "DELETE"
        
        let session = URLSession.shared
        let task = session.dataTask(with: todoURLRequest) { (data, response, error) in
            
            guard let _ = data else {
                print("error calling DELETE on /todos/1")
                return
            }
            print("DELETE okay")
        }
        task.resume()
    }
    
    func request2() {
        // POST
        let todoEndpoint = "https://jsonplaceholder.typicode.com/todos"
        guard let todoURL = URL(string: todoEndpoint) else {
            print("can't create url")
            return
        }
        var todoURLRequest = URLRequest(url: todoURL)
        todoURLRequest.httpMethod = "POST"
        let addTodo: [String: Any] = ["title": "First todo", "completed": false, "userID": 1]
        let jsonTodo: Data
        do {
            jsonTodo = try JSONSerialization.data(withJSONObject: addTodo, options: [])
            todoURLRequest.httpBody = jsonTodo
        } catch {
            print("error: cannot create JSON from todo")
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: todoURLRequest) { (data, response, error) in
            guard error == nil else {
                print("error calling POST on /todos/1")
                return
            }
            guard let responseData = data else {
                print("error: did not receive data")
                return
            }
            
            do {
                guard let receivedTodo = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any] else {
                    print("could not get JSON from responseData as dictionary")
                    return
                }
                print("the todo is: " + receivedTodo.description)
                guard let todoID = receivedTodo["id"] as? Int else {
                    print("could not get todoID as Int from JSON")
                    return
                }
                print("The ID is: \(todoID)")
            } catch {
                print("error parsing response from POST on /todos")
            }
        }
        task.resume()
    }
    
    func request1() {
        // GET
        let todoEndpoint: String = "https://jsonplaceholder.typicode.com/todos/1"
        
        guard let url = URL(string: todoEndpoint) else { return }
        
        let urlRequest = URLRequest(url: url)
        
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest, completionHandler: {
            data, response, error in
            
            guard error == nil else {
                print("error calling GET on /todos/1")
                print(error!)
                return
            }
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            // parse result as JSON
            do {
                guard let todo = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any] else {
                    print("error trying to convert data to JSON")
                    return
                }
                // print todo
                print("The todo is: " + todo.description)
                
                guard let todoTitle = todo["title"] as? String else {
                    print("error converting title")
                    return
                }
                
                print("the title is: " + todoTitle)
            } catch {
                print("error trying to convert data to JSON")
                return
            }
        })
        task.resume()
    }
}

