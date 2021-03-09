//
//  NetworkManager.swift
//  hackerNews
//
//  Created by Patrick Chen on 2021/3/6.
//

import Foundation

class NetworkManager: ObservableObject {
    
    @Published var posts = [Post]()
    
    func fetchData() {
        if let url = URL(string: "http://hn.algolia.com/api/v1/search?tags=front_page") {
            //Creating session variable
            let session = URLSession(configuration: .default)
            //Specify the task that the session is going to perform
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    //data variable was an optional; thus, use optional binding to make sure it is safe
                    if let safeData = data {
                        do {
                            //Decode the Results based on the struct defined by the PostData.swift
                            let results = try decoder.decode(Results.self, from: safeData)
                            DispatchQueue.main.async {
                                self.posts = results.hits
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            //Initialize the task
            task.resume()
        }
    }
}
