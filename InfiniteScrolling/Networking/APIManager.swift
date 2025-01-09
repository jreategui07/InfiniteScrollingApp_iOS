//
//  APIManager.swift
//  InfiniteScrolling
//
//  Created by Jonathan Reátegui on 2025-01-08.
//

import Foundation

class APIManager {
    
    static let shared = APIManager()
    let baseURL = "https://freetestapi.com/api/v1/animals"
    
    func fetchAnimals(page: Int, limit: Int, completion: @escaping ([Animal]) -> Void) {
        let urlString = "\(baseURL)?_page=\(page)&_limit=\(limit)"
        
        guard let url = URL(string: urlString) else {
            completion([])
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error al cargar los datos: \(error.localizedDescription)")
                completion([])
                return
            }
            
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode([Animal].self, from: data)
                    completion(decodedData)
                } catch {
                    print("Error al decodificar los datos: \(error)")
                    completion([])
                }
            } else {
                completion([])
            }
        }
        
        task.resume()
    }
}
