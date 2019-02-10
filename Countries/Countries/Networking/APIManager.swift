//
//  APIManager.swift
//  Countries
//
//  Created by Aniket K on 2/9/19.
//  Copyright © 2019 Aniket K. All rights reserved.
//

import UIKit

typealias JSONArray = [AnyObject]
typealias QueryResult = ([Country]?, String) -> ()

class APIManager {
    
    var countriesArray: [Country] = []
    var dataTask: URLSessionDataTask?
    let defaultSession = URLSession(configuration: .default)
    var downloadsSession: URLSession!
    var errorMessage = ""
    
    func getSearchResults(searchTerm: String, completion: @escaping QueryResult) {
        dataTask?.cancel()
        
        var countriesURL = String(format:"https://restcountries.eu/rest/v2/name/%@",searchTerm)
        var urlComponents = URLComponents(string: countriesURL)
        
        guard let url = urlComponents?.url else { return }
        
        dataTask = defaultSession.dataTask(with: url) { data, response, error in
            defer { self.dataTask = nil }
            
            if let error = error {
                self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                self.updateSearchResults(data)
                DispatchQueue.main.async {
                    completion(self.countriesArray, self.errorMessage)
                }
            }
        }
        dataTask?.resume()
    }
    
    func startDownload(_ track: Country) {
    }
        
    // MARK: - Helper methods
    fileprivate func updateSearchResults(_ data: Data) {
        countriesArray.removeAll()
        do {
            let jsonWithObjectRoot = try? JSONSerialization.jsonObject(with: data, options: [])
            if let rootCountriesArray = jsonWithObjectRoot as? JSONArray
            {
                for countryInfo in rootCountriesArray {
                    let name  = countryInfo["name"] as? String
                    let flag = countryInfo["flag"] as? String
                    countriesArray.append(Country(name: name ?? "<NA>", flagURL: flag ?? ""))
                }
            }
        }
//        catch let parseError as NSError {
//            errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
//            return
//        }
        
    }
    
    func localFilePath(for url: URL) -> URL {
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsPath.appendingPathComponent(url.lastPathComponent)
    }
    
}
