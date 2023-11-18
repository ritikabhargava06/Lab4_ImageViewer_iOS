//
//  Service.swift
//  Lab4_101023
//
//  Created by user248634 on 10/10/23.
//

import UIKit

class Service{
    
    private init(){}
    static var shared = Service()
    
    func getImage(urlString:String, completion: @escaping (Data?)->()){
        guard let url = URL(string: urlString)else{
            return
        }
        
       let myQ = DispatchQueue(label: "myQ")
        myQ.async {
           let imageData = try? Data(contentsOf: url)
            
            completion(imageData)
        }
    }
}
