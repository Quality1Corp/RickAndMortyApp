//
//  ListCharactersView.swift
//  RickAndMortyApp
//
//  Created by MikhaiL on 08.10.2023.
//

import UIKit

final class ListCharactersView: UITableViewController {
    
    private var character: RickAndMorty?
    private var viewModel = ListCharactersViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(
            ListCharactersCell.self,
            forCellReuseIdentifier: ListCharactersCell.identifier
        )
        
        setupNavigationBar()
        setupView()
        
        viewModel.fetchCharacter(from: Link.rickAndMortyURL.rawValue) { [unowned self] result in
            self.character = result
            self.tableView.reloadData()
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
        tableView.backgroundColor = #colorLiteral(red: 0.6748661399, green: 0.8078844547, blue: 0.6908774376, alpha: 1)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }
}

// MARK: - UITableViewDataSource
extension ListCharactersView {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        character?.results.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListCharactersCell.identifier, for: indexPath) as? ListCharactersCell else {
            return UITableViewCell()
        }
        
        let character = character?.results[indexPath.row]
        cell.configure(with: character)
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ListCharactersView {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episodeListView = EpisodeListView()
        let selectedCharacter = character?.results[indexPath.row]
        episodeListView.character = selectedCharacter
        
        navigationController?.pushViewController(episodeListView, animated: true)
    }
}
