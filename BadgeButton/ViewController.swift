import UIKit

class ViewController: UIViewController {
  
  let bell1 = BadgeButton(icon: UIImage(named: "bell")!)
  let bell2 = BadgeButton(icon: UIImage(named: "bell")!, shouldLimitValueTo9: true)
  lazy var sv: UIStackView = {
    let s = UIStackView(arrangedSubviews: [bell1, bell2])
    s.axis = .horizontal
    s.translatesAutoresizingMaskIntoConstraints = false
    s.spacing = 50
    return s
  }()
  
  var badgeCount = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(sv)
    NSLayoutConstraint.activate([
      sv.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
      sv.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      bell1.widthAnchor.constraint(equalToConstant: 50),
      bell1.heightAnchor.constraint(equalToConstant: 50),
    ])
  }
  
  
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
