//
//  BadgeButton.swift
//  BadgeButton
//
//  Created by Glenn Posadas on 3/16/22.
//

import UIKit

/**
 A subclass of `UIButton` that has a badge view ready.
 
 Use the convenience init, like so:
 
 ```
 let b = BadgeButton(icon: UIImage(named: "bell")!)
 ```
 
 */
class BadgeButton: UIButton {
  
  // MARK: - Properties
  
  let defaultRedBadgeBG = UIColor(red: 0.733, green: 0.208, blue: 0.392, alpha: 1)
  let defaultCornerRadius: CGFloat = 5
  let defaultFontSize: CGFloat = 11
  let defaultBadgeSize = CGSize(width: 17, height: 17)
  
  private lazy var badgeBGView: UIView = {
    let v = UIView()
    v.backgroundColor = defaultRedBadgeBG
    v.layer.cornerRadius = defaultCornerRadius
    v.translatesAutoresizingMaskIntoConstraints = false
    v.alpha = 0
    v.addSubview(badgeCountLabel)
    NSLayoutConstraint.activate([
      badgeCountLabel.topAnchor.constraint(equalTo: v.topAnchor),
      badgeCountLabel.bottomAnchor.constraint(equalTo: v.bottomAnchor),
      badgeCountLabel.leadingAnchor.constraint(equalTo: v.leadingAnchor),
      badgeCountLabel.trailingAnchor.constraint(equalTo: v.trailingAnchor)
    ])
    return v
  }()
  
  private lazy var badgeCountLabel: UILabel = {
    let l = UILabel()
    l.textColor = .white
    l.textAlignment = .center
    l.font = .systemFont(ofSize: defaultFontSize)
    l.layer.cornerRadius = defaultCornerRadius
    l.translatesAutoresizingMaskIntoConstraints = false
    return l
  }()
  
  var icon: UIImage!
  
  // MARK: - Functions
  // MARK: Overrides
  
  private override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  convenience init(icon: UIImage) {
    self.init(frame: .zero)
    
    self.icon = icon
    layout()
  }
  
  private func layout() {
    setImage(
      icon,
      for: .normal
    )
    
    addSubview(badgeBGView)
    NSLayoutConstraint.activate([
      badgeBGView.widthAnchor.constraint(greaterThanOrEqualToConstant: defaultBadgeSize.width),
      badgeBGView.heightAnchor.constraint(equalToConstant: defaultBadgeSize.height),
      badgeBGView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
      badgeBGView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Public

extension BadgeButton {
  /// Takes a new value in integer form.
  /// It's best for a single up to 2 characters.
  /// For double digit values, you could probably use 9+.
  func setBadgeValue(_ value: Int) {
    DispatchQueue.main.async {
      if self.badgeBGView.alpha == 0 {
        UIView.animate(withDuration: 0.3) {
          self.badgeBGView.alpha = 1
        }
      }
      
      UIView.transition(with: self.badgeCountLabel,
                        duration: 0.3,
                        options: .transitionFlipFromBottom,
                        animations: {
        let text: String = value >= 10 ? "9+" : "\(value)"
        self.badgeCountLabel.text = text
      }, completion: nil)
    }
  }
  
  /// Remove the badge.
  func removeBadge() {
    UIView.animate(withDuration: 0.3) {
      self.badgeCountLabel.text = ""
      self.badgeBGView.alpha = 0
    }
  }
}
