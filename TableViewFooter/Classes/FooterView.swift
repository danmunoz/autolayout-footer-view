//
//  FooterView.swift
//  TableViewFooter
//
//  Created by Daniel Munoz on 08.03.20.
//  Copyright © 2020 danmunoz. All rights reserved.
//

import UIKit

final class FooterView: UIView {

    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    init(text: String) {
        super.init(frame: .zero)
        self.contentLabel.text = text
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        self.addSubview(self.contentLabel)

        // Hack to fix AutoLayout bug related to UIView-Encapsulated-Layout-Width
        let leadingContraint = self.contentLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor)
        leadingContraint.priority = .defaultHigh

        // Hack to fix AutoLayout bug related to UIView-Encapsulated-Layout-Height
        let topConstraint = self.contentLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor)
        topConstraint.priority = .defaultHigh

        NSLayoutConstraint.activate([
            leadingContraint,
            topConstraint,
            self.contentLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            self.contentLabel.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor)
        ])
    }

}
