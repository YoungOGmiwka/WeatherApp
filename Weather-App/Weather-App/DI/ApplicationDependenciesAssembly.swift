//
//  ApplicationDependenciesAssembly.swift
//  Weather-App
//
//  Created by Михаил on 27.09.2023.
//

import Foundation
import UIKit
import Swinject

// Обертка над Swinject.Container для того, чтобы в скоупе приложения видны наружу были только Assembly модулей
final class ApplicationDependenciesAssembly {
    
    static let shared = ApplicationDependenciesAssembly(container: Container())
    
    private let container: Container
    
    private init(container: Container) {
        self.container = container
    }
    
    lazy var rootViewController: UINavigationController? = {
        container.resolve(UINavigationController.self)
    }()
    
    lazy var searchCityAssembly: ISearchCityAssembly? = {
        container.resolve(ISearchCityAssembly.self)
    }()
    
    // Регистрирует зависимости в Swinject.Container
    func injectDependencies() {
        // Корневой контейнер для экранов
        container.register(UINavigationController.self) { _ in
            return UINavigationController()
        }
        // Ассембли модуля поиска городов
        container.register(ISearchCityAssembly.self) { _ in
            SearchCityAssembly()
        }
    }
}
