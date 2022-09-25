//
//  RestaurantData.swift
//  RestaurantApp
//
//  Created by Kavya on 23/09/22.
//

import Foundation

// MARK: - WelcomeElement
struct RestaurantData: Codable {
    let name: String
    let price: Int
    let instock: Bool
}

typealias DataList = [String: [RestaurantData]]
