//
//  Presenter.swift
//  viper-crypto
//
//  Created by Turan Aktaş on 6.02.2023.
//

import Foundation

enum NetworkError : Error{
    case NetworkFailed
    case ParsingFailed
}
// talks to interactor router and view

protocol AnyPresenter {
    var router : AnyRouter? {get set}
    var interactor : AnyInteractor? {get set}
    var view : AnyView? {get set}
    
    
    func interactorDidDownloadCrypto(result : Result<[Crypto], Error>)
}

class CryptoPresenter : AnyPresenter {
    var router: AnyRouter?
    
    var interactor: AnyInteractor? {
        didSet{
            interactor?.downloadCryptos()
        }
    }
    
    var view: AnyView?
    
    func interactorDidDownloadCrypto(result: Result<[Crypto], Error>) {
        switch result{
        case .success(let cryptos):
                print("success")
                view?.update(with: cryptos)
        case .failure(_):
                view?.update(with: NetworkError.NetworkFailed)
                print("error")
        }
    }
    
     
}
