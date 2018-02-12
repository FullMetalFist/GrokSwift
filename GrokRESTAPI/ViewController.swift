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
            guard let json = response.result.value as? [String: Any] else {
                print("didn't get todo object as JSON from API")
                print("Error: \(String(describing: response.result.error))")
                return
            }
            print(json)
        }
            .responseString { response in
                if let error = response.result.error {
                    print(error)
                }
                if let value = response.result.value {
                    print(value)
                }
        }
    }
}

