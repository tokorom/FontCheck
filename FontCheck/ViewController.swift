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
    @IBOutlet private weak var fontSizeTextField: UITextField?

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

    @IBAction func textDidChange(textField: UITextField) {
        updateLabel()
    }

    @IBAction func stepperDidChange(stepper: UIStepper) {
        let fontSize = CGFloat(stepper.value)

        style.fontSize = fontSize

        fontSizeTextField?.text = String(describing: fontSize)
    }

    @IBAction func fontSizeTextDidChange(textField: UITextField) {
        guard let value = Double(textField.text ?? "") else {
            return
        }

        let fontSize = CGFloat(value)

        style.fontSize = fontSize
    }

    @IBAction func segmentedChanged(segmented: UISegmentedControl) {
        switch segmented.selectedSegmentIndex {
        case 0:
            style.fontKind = .system
        default:
            style.fontKind = .hiragino
        }
    }

    @IBAction func tapGesture(sender: AnyObject) {
        textField?.resignFirstResponder()
        fontSizeTextField?.resignFirstResponder()
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
