//
//  NetworkLayer.swift
//  Month6-HomeWork3
//
//  Created by Mac User on 12/1/24.
//

import Foundation

struct NetworkLayer {
    
    enum HTTPMethod: String {
        case DELETE, PUT, POST, GET
    }
    
    private let baseURL = URL(string: "https://dummyjson.com/products")!
    
    private let decoder = JSONDecoder()
    
    private let encoder = JSONEncoder()
    
    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void){
        let request =  URLRequest(url: baseURL)
        let urlSession = URLSession.shared.dataTask(with: request) { data, response, error in
            print("Response is: ---------------------------- \n\(response) \n ----------------------------")
            if let error {
                completion(Result.failure(error))
            }
            if let data {
                do {
                    let pr = try decoder.decode(Products.self, from: data).products
                    completion(.success(pr))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        urlSession.resume()
    }
    
    func addNewProduct(with product: Products, completion: @escaping (Result<String, Error>) -> Void) {
        do {
            var request =  URLRequest(url: baseURL)
            request.httpMethod = HTTPMethod.POST.rawValue
            request.httpBody = try encoder.encode(product )
            let urlSession = URLSession.shared.dataTask(with: request) { data, response, error in
                print("Response is: ---------------------------- \n\(response) \n ----------------------------")
                if let error {
                    completion(Result.failure(error))
                }
                if let data {
                    completion(.success("Succesa"))
                }
            }
            urlSession.resume()
        } catch {
            completion(.failure(error))
        }
    }
    
    func updateProduct(with product: Product, completion: @escaping (Result<String, Error>) -> Void) {
        do {
            let url = baseURL.appendingPathComponent("\(product.id)")
            var request =  URLRequest(url: url)
            request.httpMethod = HTTPMethod.PUT.rawValue
            request.httpBody = try encoder.encode(product )
            let urlSession = URLSession.shared.dataTask(with: request) { data, response, error in
                print("Response is: ---------------------------- \n\(response) \n ----------------------------")
                if let error {
                    completion(Result.failure(error))
                }
                if let data {
                    completion(.success("Succesa"))
                }
            }
            urlSession.resume()
        } catch {
            completion(.failure(error))
        }
    }
    
    func deleteProduct(with product: Product, completion: @escaping (Result<String, Error>) -> Void) {
        let url = baseURL.appendingPathComponent("\(product.id)")
        var request =  URLRequest(url: url)
        request.httpMethod = HTTPMethod.DELETE.rawValue
        let urlSession = URLSession.shared.dataTask(with: request) { data, response, error in
            print("Response is: ---------------------------- \n\(response) \n ----------------------------")
            if let error {
                completion(Result.failure(error))
            }
            if let data {
                completion(.success("Succesa"))
            }
        }
        urlSession.resume()
    }
}
