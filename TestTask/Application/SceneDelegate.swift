//
//  SceneDelegate.swift
//  TestTask
//
//  Created by Игорь Дикань on 28.03.2022.
//

import UIKit

// MARK: - SceneDelegate
final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        setupRootViewController(with: windowScene)
    }
}

// MARK: - Private methods
private extension SceneDelegate {
    
    func setupRootViewController(with windowScene: UIWindowScene) {
        let window = UIWindow(windowScene: windowScene)
        let sceneBuilderService = SceneBuilderService()
        let mainViewController = sceneBuilderService.buildMainScene()
        window.rootViewController = mainViewController
        window.makeKeyAndVisible()
        self.window = window
    }
}
