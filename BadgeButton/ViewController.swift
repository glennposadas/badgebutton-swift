import UIKit

class ViewController: UIViewController {
  
  //let b = BadgeButton(icon: UIImage(named: "bell")!)
  let b = BadgeButton(icon: UIImage(named: "bell")!, shouldLimitValueTo9: true)
  
  var badgeCount = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    view.addSubview(b)
    b.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      b.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
      b.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      b.widthAnchor.constraint(equalToConstant: 44),
      b.heightAnchor.constraint(equalToConstant: 44)
    ])
  }
  
  
  @IBAction func increment(_ sender: Any) {
    badgeCount += 1
    b.setBadgeValue(badgeCount)
  }
  
  @IBAction func hidgeBadge(_ sender: Any) {
    badgeCount = 0
    b.removeBadge()
  }
}
