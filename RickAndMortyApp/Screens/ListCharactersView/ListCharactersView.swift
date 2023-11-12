//
//  ListCharactersView.swift
//  RickAndMortyApp
//
//  Created by MikhaiL on 08.10.2023.
//

import UIKit

final class ListCharactersView: UITableViewController {
    
    // MARK: - Private properties
    private var character: RickAndMorty?
    private var viewModel = ListCharactersViewModel()
    
    private var currentPage = 1 {
        didSet {
            if currentPage == 1 {
                previousPageBarButton.isEnabled = false
            }
        }
    }
    
    private lazy var previousPageBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.title = "Previous page"
        barButton.tintColor = .white
        barButton.style = .done
        barButton.target = self
        barButton.action = #selector(updateCharacters)
        return barButton
    }()
    
    private lazy var nextPageBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.title = "Next page"
        barButton.tintColor = .white
        barButton.style = .done
        barButton.target = self
        barButton.action = #selector(updateCharacters)
        return barButton
    }()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupView()
    }
    
    // MARK: - Private methods
    @objc private func updateCharacters(_ sender: UIBarButtonItem) {
        if sender == nextPageBarButton {
            viewModel.fetchCharacter(from: character?.info.next ?? "") { [unowned self] result in
                self.character = result
                self.tableView.reloadData()
            }
            
            currentPage += 1
            
            if currentPage == 43 {
                nextPageBarButton.isEnabled = false
            }
            previousPageBarButton.isEnabled = true
        } else {
            viewModel.fetchCharacter(from: character?.info.prev ?? "") { [unowned self] result in
                self.character = result
                self.tableView.reloadData()
            }
            if currentPage > 1 {
                currentPage -= 1
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
        
        navigationItem.leftBarButtonItem = previousPageBarButton
        navigationItem.rightBarButtonItem = nextPageBarButton
    }
    
    private func setupView() {
        tableView.backgroundColor = #colorLiteral(red: 0.6748661399, green: 0.8078844547, blue: 0.6908774376, alpha: 1)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        tableView.register(
            ListCharactersCell.self,
            forCellReuseIdentifier: ListCharactersCell.identifier
        )
        previousPageBarButton.isEnabled = false
        
        viewModel.fetchCharacter(from: Link.rickAndMortyURL.rawValue) { [unowned self] result in
            self.character = result
            self.tableView.reloadData()
        }
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
