//
//  ViewController.swift
//  InfiniteScrolling
//
//  Created by Jonathan Reátegui on 2025-01-08.
//

import UIKit

class ViewController: UIViewController {
    var tableView: UITableView!
    var animals = Array<Animal>()
    var isLoadingData = false
    var currentPage = 1
    let pageLimit = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadData()
    }
    
    func setupTableView() {
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "AnimalCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        self.view.addSubview(tableView)
    }
    
    func loadData() {
        guard !isLoadingData else { return }
        isLoadingData = true
        APIManager.shared.fetchAnimals(page: currentPage, limit: pageLimit) { newAnimals in
            DispatchQueue.main.async {
                self.animals.append(contentsOf: newAnimals)
                self.tableView.reloadData()
                self.isLoadingData = false
                self.currentPage += 1
            }
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnimalCell", for: indexPath)
        let animal = animals[indexPath.row]
        cell.textLabel?.text = "\(animal.name)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == animals.count - 1 {
            loadData()
        }
    }
}

extension ViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if let lastVisibleIndexPath = indexPaths.last, lastVisibleIndexPath.row == animals.count - 1 {
            loadData()
        }
    }
}
