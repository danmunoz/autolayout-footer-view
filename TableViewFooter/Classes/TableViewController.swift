//
//  TableViewController.swift
//  TableViewFooter
//
//  Created by Daniel Munoz on 28.02.20.
//  Copyright © 2020 danmunoz. All rights reserved.
//

import UIKit

struct Conference {
    let name: String
    let location: String
}

final class TableViewController: UIViewController {

    private static let cellIdentifier = "CellIdentifier"

    private let swiftConferences = [
        Conference(name: "NSSpain", location: "Spain"),
        Conference(name: "PragmaConf", location: "Italy"),
        Conference(name: "Hacking with Swift Live", location: "London"),
        Conference(name: "UIKonf", location: "Germany"),
        Conference(name: "AppBuilders", location: "Switzerland"),
        Conference(name: "Swift Aveiro", location: "Portugal"),
        Conference(name: "Appdevcon", location: "The Netherlands"),
        Conference(name: "WWDC", location: "USA")
    ]

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.setupUI()
    }

    private func setupTableView() {
        self.tableView.dataSource = self
    }

    private func setupUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.tableView)
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])

        let footerView = FooterView(text: "This is the text to be displayed in the footer view. Lets just think this contains some sort of disclaimer or maybe information that needs to be always shown below the content of the table. We don't know the length of this, especially if we want to support different languages, so we rely Auto Layout to calculate the correct size.")
        self.tableView.tableFooterView = footerView
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let footerView = self.tableView.tableFooterView else {
            return
        }

        let width = self.tableView.bounds.size.width
        let size = footerView.systemLayoutSizeFitting(CGSize(width: width, height: UIView.layoutFittingCompressedSize.height))

        if footerView.frame.size.height != size.height {
            footerView.frame.size.height = size.height
            self.tableView.tableFooterView = footerView
        }
    }
}

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.swiftConferences.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewController.cellIdentifier) else {
                return UITableViewCell(style: .subtitle, reuseIdentifier: TableViewController.cellIdentifier)
            }
            return cell
        }()
        let conference = self.swiftConferences[indexPath.row]
        cell.textLabel?.text = conference.name
        cell.detailTextLabel?.text = conference.location
        return cell
    }
}
