//
//  ProductsStruct.swift
//  Month6-HomeWork3
//
//  Created by Mac User on 10/1/24.
//

import Foundation

struct Products: Codable {
    let products: [Product]
}

struct Product: Codable {
    let id: Int
    let title: String
    let description: String
    let images: String
}
