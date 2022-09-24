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
 let b = BadgeButton(icon: UIImage(named: "bell", shouldLimitValueTo9: true)!)
 ```
 
 */
@objc
class BadgeButton: UIButton {
  
  // MARK: - Properties
  
  let defaultRedBadgeBG = UIColor(red: 0.733, green: 0.208, blue: 0.392, alpha: 1)
  let defaultCornerRadius: CGFloat = 5
  let defaultFontSize: CGFloat = 11
  let defaultBadgeSize = CGSize(width: 17, height: 17)
  let errorIconSize = CGSize(width: 20, height: 20)
  
  /// Set this to true through the constructor  if you want to limit the value to 9+ if value is >= 10.
  private(set) var shouldLimitValueTo9: Bool = false
  /// Reference to prevent blinking animation
  private(set) var currentBadgeCount: Int = 0
  
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
      badgeCountLabel.leadingAnchor.constraint(equalTo: v.leadingAnchor, constant: 4),
      badgeCountLabel.trailingAnchor.constraint(equalTo: v.trailingAnchor, constant: -4)
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
  
  private lazy var errorImageView: UIImageView = {
    let i = UIImageView(image: .init(named: "ic_chat_warning"))
    i.contentMode = .scaleAspectFit
    i.alpha = 0
    return i
  }()
  
  var icon: UIImage!
  
  // MARK: - Functions
  // MARK: Overrides
  
  private override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  @objc
  convenience init(icon: UIImage, errorIcon: UIImage?) {
    self.init(frame: .zero)

    self.icon = icon
    if let errorIcon = errorIcon {
      self.errorImageView.image = errorIcon
    }
    layout()
  }
  
  @objc
  convenience init(icon: UIImage) {
    self.init(icon: icon, errorIcon: nil)
  }
  
  @objc
  convenience init(icon: UIImage, shouldLimitValueTo9: Bool) {
    self.init(icon: icon)
    self.shouldLimitValueTo9 = shouldLimitValueTo9
  }
  
  private func layout() {
    setImage(
      icon,
      for: .normal
    )
    
    addSubview(badgeBGView)
    NSLayoutConstraint.activate([
      badgeBGView.heightAnchor.constraint(equalToConstant: defaultBadgeSize.height),
      badgeBGView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
      badgeBGView.leadingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
    ])
    
    addSubview(errorImageView)
    NSLayoutConstraint.activate([
      badgeBGView.heightAnchor.constraint(equalToConstant: defaultBadgeSize.height),
      badgeBGView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
      badgeBGView.leadingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Public

@objc
extension BadgeButton {
  /// Takes a new value in integer form.
  func setBadgeValue(_ value: Int) {
    guard currentBadgeCount != value else {
      return
    }
    
    currentBadgeCount = value
    
    DispatchQueue.main.async {
      if self.badgeBGView.alpha == 0 {
        UIView.animate(withDuration: 0.3) {
          self.badgeBGView.alpha = 1
        }
      }
      
      guard value > 0 else {
        self.removeBadge()
        return
      }
     
      UIView.transition(with: self.badgeCountLabel,
                        duration: 0.3,
                        options: .transitionFlipFromBottom,
                        animations: {
        self.hideError()
        let text: String = self.shouldLimitValueTo9 ? value >= 10 ? "9+" : "\(value)" : "\(value)"
        self.badgeCountLabel.text = text
      }, completion: nil)
    }
  }
  
  /// Shows the error icon.
  /// This hides the badge, not removing its value so that it can be displayed again..
  func showError() {
    DispatchQueue.main.async {
      UIView.animate(withDuration: 0.3,
                     delay: 0,
                     options: .curveEaseOut) {
        self.badgeBGView.alpha = 0
        self.errorImageView.alpha = 1
      }
    }
  }
  
  /// Resolves the error.
  func hideError() {
    DispatchQueue.main.async {
      UIView.animate(withDuration: 0.3,
                     delay: 0,
                     options: .curveEaseOut) {
        self.errorImageView.alpha = 0
        self.badgeBGView.alpha = 1
      }
    }
  }
  
  /// Remove the badge.
  func removeBadge() {
    DispatchQueue.main.async {
      UIView.animate(withDuration: 0.3,
                     delay: 0,
                     options: .curveEaseOut) {
        self.badgeBGView.alpha = 0
        self.badgeCountLabel.text = ""
      }
    }
  }
}
