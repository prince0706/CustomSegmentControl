//
//  ButtonStyleSegmentControl.swift
//  KnowledgeAndExperience
//
//  Created by Prince on 31/07/18.
//  Copyright © 2018 Prince. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class ButtonStyleSegmentControl: UIControl {
    var buttons = [UIButton]()
    var selectedSegmentIndex = 0
	
	@IBInspectable override var borderWidth: CGFloat {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable override var cornerRadius: CGFloat {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable override var borderColor: UIColor? {
        didSet {
			layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable var commaSeperatedButtonTitles: String = "" {
        didSet {
            updateControlAppearance()
        }
    }
    
    @IBInspectable var textColor: UIColor = .lightGray {
        didSet {
            updateControlAppearance()
        }
    }
    
    @IBInspectable var selectedTextColor: UIColor = .green {
        didSet {
            updateControlAppearance()
        }
    }
    
    @IBInspectable var selectedBackgroundColor: UIColor = .blue {
        didSet {
            updateControlAppearance()
        }
    }
    
    @IBInspectable var font: UIFont? = UIFont.boldSystemFont(ofSize: 12.0) {
        didSet {
            updateControlAppearance()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateControlAppearance()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        updateControlAppearance()
    }
	
    private func updateControlAppearance() {
        buttons.removeAll()
        subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        
        let buttonTitles = commaSeperatedButtonTitles.components(separatedBy: ",")
        
        for buttonTitle in buttonTitles {
            let button = UIButton.init(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.setTitleColor(textColor, for: .normal)
            button.titleLabel?.font = font
            button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
            button.layer.cornerRadius = cornerRadius
			button.layer.borderWidth = 0.5
			button.layer.borderColor = borderColor?.cgColor
            button.contentCompressionResistancePriority(for: UILayoutConstraintAxis.horizontal)
            buttons.append(button)
        }
        
        buttons[selectedSegmentIndex].setTitleColor(selectedTextColor, for: .normal)
        buttons[selectedSegmentIndex].backgroundColor = selectedBackgroundColor
        
        // Create a StackView
        let stackView = UIStackView.init(arrangedSubviews: buttons)
		stackView.backgroundColor = selectedTextColor
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 0.0
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
	
    @objc func buttonTapped(button: UIButton) {
        buttons[selectedSegmentIndex].backgroundColor = self.backgroundColor
        for (buttonIndex, btn) in buttons.enumerated() {
            
            btn.setTitleColor(textColor, for: .normal)
            
            if btn == button {
                selectedSegmentIndex = buttonIndex
                btn.setTitleColor(selectedTextColor, for: .normal)
                button.backgroundColor = selectedBackgroundColor
            }
        }
        
        sendActions(for: .valueChanged)
    }
	
    func updateSegmentedControlSegs(index: Int) {
        for btn in buttons {
            btn.setTitleColor(textColor, for: .normal)
        }
        
        buttons[index].setTitleColor(selectedTextColor, for: .normal)
    }
}
