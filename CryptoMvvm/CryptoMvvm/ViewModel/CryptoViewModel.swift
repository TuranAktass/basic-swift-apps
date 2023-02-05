//
//  CryptoViewModel.swift
//  CryptoMvvm
//
//  Created by Turan Aktaş on 4.02.2023.
//

import Foundation

struct CryptoListViewModel{
    let cryptoCurrencyList : [CryptoCurrency]

}

extension CryptoListViewModel{
    
    func numberOfRowsInSection() -> Int{
        return self.cryptoCurrencyList.count
    }
    
    func cryptoAtIndex(_ index: Int) -> CryptoViewModel{
        let crypto = self.cryptoCurrencyList[index]
        return CryptoViewModel(crypto: crypto)
    }
}

struct CryptoViewModel{
    let crypto : CryptoCurrency
}

extension CryptoViewModel{
    var name : String {
        return self.crypto.currency
    }
    
    var price : String {
        return self.crypto.price
    }
}


