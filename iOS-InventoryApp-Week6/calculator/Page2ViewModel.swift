//
//  Page2ViewModel.swift
//  calculator
//
//  Created by Harnoor Singh on 3/3/24.
//

import Foundation

class Page2ViewModel: ObservableObject {
    
    
    // convert this to a viewmodel MVVM structure
    func getResponseFromServer() async throws -> [Inventory] {
        let endPoint = "http://20.150.211.224:8000/inventory/api"
        guard let url = URL(string: endPoint) else {
            throw InventoryError.URLError
        }
        let (data, response) =  try await URLSession.shared.data(from: url) // type -> 2
        
        guard
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300
        else {
            // todo
            throw InventoryError.ResponseError
        }
        let decoder = JSONDecoder()

        let inventoryResponse = try decoder.decode([Inventory].self, from: data)
        
        return inventoryResponse
    }
    
    func incrementInventoryCountInDatabase(inventory_obj: Inventory) async throws -> Void {
        let endPoint = "http://20.150.211.224:8000/inventory/api/\(inventory_obj.name)/"
        guard let url = URL(string: endPoint) else {
            throw InventoryError.URLError
        }
        var request = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalCacheData
        )
        request.setValue(" application/json; charset=utf-8", forHTTPHeaderField:"Content-Type")

        request.httpMethod = "PUT"
        request.httpBody = try JSONEncoder().encode(Inventory (name: inventory_obj.name, url: inventory_obj.url, count: inventory_obj.count + 1))
        let task = URLSession.shared.dataTask(with: request)
        task.resume()
    }
    
    func decrementInventoryCountInDatabase(inventory_obj: Inventory) async throws -> Void {
        let endPoint = "http://20.150.211.224:8000/inventory/api/\(inventory_obj.name)/"
        guard let url = URL(string: endPoint) else {
            throw InventoryError.URLError
        }
        var request = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalCacheData
        )
        request.setValue(" application/json; charset=utf-8", forHTTPHeaderField:"Content-Type")

        request.httpMethod = "PUT"
        request.httpBody = try JSONEncoder().encode(Inventory (name: inventory_obj.name, url: inventory_obj.url, count: inventory_obj.count - 1))
        let task = URLSession.shared.dataTask(with: request)
        task.resume()
    }
}
 
enum InventoryError: Error {
    case ResponseError
    case URLError
}

struct InventoryResponse: Codable { // conforms to a protocol Codable
    var inventories: [Inventory]
}

struct Inventory : Codable, Identifiable {
    let id = UUID() // we are not expecting from the server
    var name: String
    var url: String
    var count: Int
}

