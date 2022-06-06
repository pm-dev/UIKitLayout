//
//  View.swift
//  UIKitLayout-Example
//
//  Created by Peter Meyers on 7/17/20.
//  Copyright © 2020 Peter Meyers, Inc. All rights reserved.
//

import Foundation
import UIKit
import UIKitLayout

final class View: UIView {

    private let label: UILabel = {
        let label = UILabel()
        label.text = """
        Padmé tatooine darth anakin solo wicket antilles dooku. Jawa darth sidious calamar
        """
        label.numberOfLines = 0
        return label
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "puppies.jpg")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .gray
        return imageView
    }()

    private let redView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        // Use the space below to practice laying out views

        embed(redView, pin: [.top(toLayoutGuide: .safeArea, offset: 20), .leading(offset: 20), .trailing(offset: -20)])
        redView.embed(imageView, pin: [.top(offset: 10), .leading(offset: 10), .trailing(offset: -10)])
        redView.embed(label, pin: [.bottom(offset: -10), .leading(offset: 10), .trailing(offset: -10)])
        imageView.bottom.pin(to: label.top, spacing: 5)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
