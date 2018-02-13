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
        getRequestAlamo()
    }
    
    func getRequestAlamo() {
        let todoEndpoint: String = "https://jsonplaceholder.typicode.com/todos/1"
        Alamofire.request(todoEndpoint).responseJSON { response in
            
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
        let todoEndpoint: String = "https://jsonplaceholder.typicode.com/todos"
        
        let newTodo: [String: Any] = ["title": "First Alamo Post", "completed": 0, "userId": 1]
        Alamofire.request(todoEndpoint, method: .post, parameters: newTodo, encoding: JSONEncoding.default).responseJSON { response in
            
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
        let todoEndpoint: String = "https://jsonplaceholder.typicode.com/todos/1"
        
        Alamofire.request(todoEndpoint, method: .delete).responseJSON { response in
            guard response.result.error == nil else {
                print("error calling DELETE on /todos/1")
                print(response.result.error!)
                return
            }
            print("DELETE ok")
        }
    }
}

