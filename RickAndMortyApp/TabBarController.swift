//
//  TabBarController.swift
//  RickAndMortyApp
//
//  Created by MikhaiL on 14.10.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        viewControllers = createViewControllers()
        tabBar.tintColor = .blue
        tabBar.unselectedItemTintColor = .gray
        tabBar.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createViewControllers() -> [UIViewController] {
        var viewControllers: [UIViewController] = []
        
        let listCharacter = ListCharactersView()
        listCharacter.tabBarItem = UITabBarItem(
            title: "Characters",
            image: UIImage(systemName: "person.3"),
            selectedImage: UIImage(systemName: "person.3.fill")
        )
        
        let charactersNavigationController = UINavigationController(rootViewController: listCharacter)
        viewControllers.append(charactersNavigationController)
        
        let settingsView = SettingsView()
        settingsView.tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "gearshape"),
            selectedImage: UIImage(systemName: "gearshape.fill")
        )
        viewControllers.append(settingsView)
        
        return viewControllers
    }
}
