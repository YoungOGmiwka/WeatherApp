//
//  SceneDelegate.swift
//  Weather-App
//
//  Created by Михаил on 27.09.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene),
              let rootViewController = ApplicationDependenciesAssembly.shared.rootViewController,
              let assembly = ApplicationDependenciesAssembly.shared.searchCityAssembly
        else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
        window?.rootViewController = rootViewController
        
        let coordinator = ApplicationCoordinator(transitionHandler: rootViewController, searchCityAssembly: assembly)
        coordinator.start()
    }
}
