//
//  CryptoService.swift
//  CryptoMvvm
//
//  Created by Turan Aktaş on 4.02.2023.
//

import Foundation


class WebService {
    func getCurrencies(url: URL, completion: @escaping ([CryptoCurrency]?) -> ()){
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
                if let error = error {
                    print(error.localizedDescription)
                    completion(nil)
                } else if let data = data{
                    let cryptoList = try? JSONDecoder().decode([CryptoCurrency].self,  from: data)
                    completion(cryptoList)
                }
        }.resume()
    }
}
