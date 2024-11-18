import UIKitLayout
import XCTest

final class PinTests: XCTestCase {

    // MARK: Internal

    @MainActor
    override func setUp() async throws {
        parent = UIView()
        first = UIView()
        second = UIView()
        parent.addSubview(first)
        parent.addSubview(second)
    }

    @MainActor
    func testVerticalPin() {
        AssertEqualConstraints(
            first.bottom.pin(to: second.top, spacing: 5),
            NSLayoutConstraint(
                item: first as Any,
                attribute: .bottom,
                relatedBy: .equal,
                toItem: second,
                attribute: .top,
                multiplier: 1,
                constant: -5
            ) <- { $0.isActive = true }
        )

        AssertEqualConstraints(
            first.top.pin(to: second.bottom, spacing: 5),
            NSLayoutConstraint(
                item: first as Any,
                attribute: .top,
                relatedBy: .equal,
                toItem: second,
                attribute: .bottom,
                multiplier: 1,
                constant: 5
            ) <- { $0.isActive = true }
        )
    }

    @MainActor
    func testHorizontalPin() {
        AssertEqualConstraints(
            first.trailing.pin(to: second.leading, spacing: 2),
            NSLayoutConstraint(
                item: first as Any,
                attribute: .trailing,
                relatedBy: .equal,
                toItem: second,
                attribute: .leading,
                multiplier: 1,
                constant: -2
            ) <- { $0.isActive = true }
        )

        AssertEqualConstraints(
            first.leading.pin(to: second.trailing, spacing: 2),
            NSLayoutConstraint(
                item: first as Any,
                attribute: .leading,
                relatedBy: .equal,
                toItem: second,
                attribute: .trailing,
                multiplier: 1,
                constant: 2
            ) <- { $0.isActive = true }
        )
    }

    @MainActor
    func testPinGte() {
        AssertEqualConstraints(
            first.trailing.pin(to: second.leading, .greaterThanOrEqual, spacing: 2),
            NSLayoutConstraint(
                item: first as Any,
                attribute: .trailing,
                relatedBy: .lessThanOrEqual,
                toItem: second,
                attribute: .leading,
                multiplier: 1,
                constant: -2
            ) <- { $0.isActive = true }
        )

        AssertEqualConstraints(
            first.leading.pin(to: second.trailing, .greaterThanOrEqual, spacing: 2),
            NSLayoutConstraint(
                item: first as Any,
                attribute: .leading,
                relatedBy: .greaterThanOrEqual,
                toItem: second,
                attribute: .trailing,
                multiplier: 1,
                constant: 2
            ) <- { $0.isActive = true }
        )
    }

    @MainActor
    func testPinLte() {
        AssertEqualConstraints(
            first.trailing.pin(to: second.leading, .lessThanOrEqual, spacing: 2),
            NSLayoutConstraint(
                item: first as Any,
                attribute: .trailing,
                relatedBy: .greaterThanOrEqual,
                toItem: second,
                attribute: .leading,
                multiplier: 1,
                constant: -2
            ) <- { $0.isActive = true }
        )

        AssertEqualConstraints(
            first.leading.pin(to: second.trailing, .lessThanOrEqual, spacing: 2),
            NSLayoutConstraint(
                item: first as Any,
                attribute: .leading,
                relatedBy: .lessThanOrEqual,
                toItem: second,
                attribute: .trailing,
                multiplier: 1,
                constant: 2
            ) <- { $0.isActive = true }
        )
    }

    @MainActor
    func testPinMargins() {
        AssertEqualConstraints(
            first.layoutMarginsGuide.bottom.pin(to: second.layoutMarginsGuide.top),
            NSLayoutConstraint(
                item: first.layoutMarginsGuide,
                attribute: .bottom,
                relatedBy: .equal,
                toItem: second.layoutMarginsGuide,
                attribute: .top,
                multiplier: 1,
                constant: 0
            ) <- { $0.isActive = true }
        )
    }

    @MainActor
    func testPinSafeArea() {
        AssertEqualConstraints(
            first.safeAreaLayoutGuide.bottom.pin(to: second.top),
            NSLayoutConstraint(
                item: first.safeAreaLayoutGuide,
                attribute: .bottom,
                relatedBy: .equal,
                toItem: second,
                attribute: .top,
                multiplier: 1,
                constant: 0
            ) <- { $0.isActive = true }
        )
    }

    @MainActor
    func testPinReadableContent() {
        AssertEqualConstraints(
            first.bottom.pin(to: second.readableContentGuide.top),
            NSLayoutConstraint(
                item: first as Any,
                attribute: .bottom,
                relatedBy: .equal,
                toItem: second.readableContentGuide,
                attribute: .top,
                multiplier: 1,
                constant: 0
            ) <- { $0.isActive = true }
        )
    }

    @MainActor
    func testPinUnrequired() {
        AssertEqualConstraints(
            first.bottom.pin(to: second.top, priority: .defaultHigh),
            NSLayoutConstraint(
                item: first as Any,
                attribute: .bottom,
                relatedBy: .equal,
                toItem: second,
                attribute: .top,
                multiplier: 1,
                constant: 0
            ) <- { $0.isActive = true; $0.priority = .defaultHigh }
        )
    }

    @MainActor
    func testPinUnactivated() {
        AssertEqualConstraints(
            first.bottom.pin(to: second.top, activate: false),
            NSLayoutConstraint(
                item: first as Any,
                attribute: .bottom,
                relatedBy: .equal,
                toItem: second,
                attribute: .top,
                multiplier: 1,
                constant: 0
            ) <- { $0.isActive = false }
        )
    }

    // MARK: Private

    private var parent: UIView!
    private var first: UIView!
    private var second: UIView!
}
