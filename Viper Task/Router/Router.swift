//
//  Router.swift
//  Viper Task
//
//  Created by Apple on 16/11/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit

var presenterObject :PresenterInputProtocol?

class Router: PresenterToRouterProtocol {
    
    
    
    static var storyBoard: UIStoryboard {
        return UIStoryboard.init(name: "Main", bundle: Bundle.main)
    }
    
    static func createModule() -> UIViewController {
        
        
        
        let presenter: PresenterInputProtocol & InteractorToPresenterProtocol = Presenter()
        let interactor: PresenterToInteractorProtocol & WebServiceToInteractor = Interactor()
        let router:PresenterToRouterProtocol = Router()
        let mainWebservice : WebServiceProtocol = Webservice()
        
        let view = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            
        presenter.view = view
            view.presenter = presenter
       
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.webService = mainWebservice
        mainWebservice.interactor = interactor
        return view
    }
    
    static func MainModule() -> UIViewController {
        let presenter: PresenterInputProtocol & InteractorToPresenterProtocol = Presenter()
        let interactor: PresenterToInteractorProtocol & WebServiceToInteractor = Interactor()
        let router:PresenterToRouterProtocol = Router()
        let mainWebservice : WebServiceProtocol = Webservice()
        
        let mainView = storyBoard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
            
        presenter.view = mainView
        mainView.presenter = presenter
       
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.webService = mainWebservice
        mainWebservice.interactor = interactor
        return mainView
    }
    
    static func TrxnModule() -> UIViewController {
        
        let presenter: PresenterInputProtocol & InteractorToPresenterProtocol = Presenter()
        let interactor: PresenterToInteractorProtocol & WebServiceToInteractor = Interactor()
        let router:PresenterToRouterProtocol = Router()
        let mainWebservice : WebServiceProtocol = Webservice()
        
        let mainView = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            
        presenter.view = mainView
        mainView.presenter = presenter
       
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.webService = mainWebservice
        mainWebservice.interactor = interactor
        return mainView
    }
}
