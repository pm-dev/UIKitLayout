import Foundation
import UIKit
import UIKitLayout

final class View: UIView {

    private(set) lazy var label: UILabel = {
        let label = UILabel()
        label.text = """
        Padmé tatooine darth anakin solo wicket antilles dooku. Jawa darth sidious calamar
        """
        label.numberOfLines = 0
        return label
    }()

    private(set) lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "puppies.jpg")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .gray
        return imageView
    }()

    private(set) lazy var redView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()

    private(set) lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        embedSubviews()
    }

    private func embedSubviews() {
        // Use the space below to practice laying out views

        embed(redView, pin: [.top(toLayoutGuide: .safeArea, inset: 20), .leading(inset: 20), .trailing(inset: 20)])
        redView.embed(imageView, pin: [.top(inset: 10), .leading(inset: 10), .trailing(inset: 10)])
        redView.embed(label, pin: [.bottom(inset: 10), .leading(inset: 10), .trailing(inset: 10)])
        imageView.bottom.pin(to: label.top, spacing: 5)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
