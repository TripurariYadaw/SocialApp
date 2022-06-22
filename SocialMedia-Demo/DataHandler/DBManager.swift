//
//  DBManager.swift
//  SocialMedia-Demo
//
//  Created by User on 21/06/22.
//


import Foundation

protocol FeedServiceProtocol {
    func getFeeds(completion: @escaping (_ success: Bool, _ results: Feeds?, _ error: String?) -> ())
}

class FeedsService: FeedServiceProtocol {
    func getFeeds(completion: @escaping (Bool, Feeds?, String?) -> ()) {
        do {
            if let path = Bundle.main.url(forResource: "FeedData", withExtension: "json") {
              let data = try Data(contentsOf: path)
              let decoder = JSONDecoder()
              let model = try decoder.decode(Feeds.self, from: data)
                    completion(true, model, nil)
                }else {
                completion(false, nil, "Error: Employees GET Request failed")
            }
        } catch {
          print(error.localizedDescription)
        }
    }
}
