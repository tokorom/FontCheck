//
//  ViewController.swift
//  FontCheck
//
//  Created by Yuta Tokoro on 2022/05/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var label: UILabel?
    @IBOutlet private weak var textField: UITextField?

    private var style: FontStyle = .init() {
        didSet {
            updateLabel()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        updateLabel()
    }

    private func updateLabel() {
        guard let text = textField?.text else {
            return
        }

        let font = style.font

        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttributes(
            [.font: font],
            range: NSRange(location: 0, length: attributedString.length)
        )

        label?.attributedText = attributedString
    }
}

// MARK: - FontStyle

struct FontStyle {
    var fontKind: FontKind = .system
    var fontSize: CGFloat = 16

    var font: UIFont {
        switch fontKind {
        case .system:
            return UIFont.systemFont(ofSize: fontSize)
        case .hiragino:
            return UIFont(name: "Hiragino Sans", size: fontSize)!
        }
    }
}

enum FontKind {
    case system
    case hiragino
}
