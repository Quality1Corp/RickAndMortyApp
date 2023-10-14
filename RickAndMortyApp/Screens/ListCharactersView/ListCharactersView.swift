//
//  ListCharactersView.swift
//  RickAndMortyApp
//
//  Created by MikhaiL on 08.10.2023.
//

import UIKit

final class ListCharactersView: UITableViewController {
    private var viewModel = ListCharactersViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(
            ListCharactersCell.self,
            forCellReuseIdentifier: ListCharactersCell.identifier
        )
        
        setupNavigationBar()
        setupView()
        
        viewModel.fetchCharacter(from: Link.rickAndMorty.url) { [unowned self] _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func setupNavigationBar() {
        title = "Characters"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        navigationItem.setHidesBackButton(true, animated: true)
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = UIColor.blue
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    private func setupView() {
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }
}

// MARK: - UITableViewDataSource
extension ListCharactersView {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfCharacters()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListCharactersCell.identifier, for: indexPath) as? ListCharactersCell else {
            return UITableViewCell()
        }
        
        let char = viewModel.characters[indexPath.row]
        cell.configure(with: char)
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ListCharactersView {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}
