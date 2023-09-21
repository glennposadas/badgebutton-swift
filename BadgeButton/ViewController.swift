import UIKit

class ViewController: UIViewController {
  
  let bell1 = BadgeButton(icon: UIImage(named: "bell")!)
  let bell2 = BadgeButton(icon: UIImage(named: "bell")!, shouldLimitValueTo9: true)

  var badgeCount = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(bell1)
    view.addSubview(bell2)
    
    setupConstraints()
    addTargets()
  }
  
  private func setupConstraints() {
    bell1.translatesAutoresizingMaskIntoConstraints = false
    bell2.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      bell1.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
      bell1.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -50),
      bell1.heightAnchor.constraint(equalToConstant: 44),
      
      bell2.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
      bell2.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 50),
      bell2.heightAnchor.constraint(equalToConstant: 44),
    ])
  }
  
  private func addTargets() {
    bell1.addTarget(self, action: #selector(bell1Tapped), for: .touchUpInside)
    bell2.addTarget(self, action: #selector(bell2Tapped), for: .touchUpInside)
  }
  
  // MARK: -
  // MARK: Bell Selectors
  
  @objc
  private func bell1Tapped() {
    print("bell1Tapped")
  }
  
  @objc
  private func bell2Tapped() {
    print("bell2Tapped")
  }
  
  // MARK: -
  // MARK: Test Buttons
  
  @IBAction func increment(_ sender: Any) {
    badgeCount += 1
    bell1.setBadgeValue(badgeCount)
    bell2.setBadgeValue(badgeCount)
  }
  
  @IBAction func hidgeBadge(_ sender: Any) {
    badgeCount = 0
    bell1.removeBadge()
    bell2.removeBadge()
  }
  
  @IBAction func showError(_ sender: Any) {
    bell1.showError()
    bell2.showError()
  }
}
