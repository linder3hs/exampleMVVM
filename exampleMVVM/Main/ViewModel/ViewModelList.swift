//
//  ViewModelList.swift
//  exampleMVVM
//
//  Created by Linder Hassinger on 29/04/21.
//

import Foundation

class ViewModelList {
    
    var refreshData = { () -> () in }
        
    var dataArray: [List] = [] {
        didSet {
            refreshData()
        }
    }
    
    func retriveDataList() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let json = data else { return }
            
            do {
                let decoder = JSONDecoder()
                self.dataArray = try decoder.decode([List].self, from: json)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }.resume()
    }
        
    
}
