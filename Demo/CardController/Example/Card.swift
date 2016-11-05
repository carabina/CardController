

import UIKit

class Card: UIViewController {
    
    
    
    let cardTitle: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 0 // set to 0 to force to display untruncated text.
        label.textAlignment = .natural
        label.textColor = .darkGray
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.layer.cornerRadius = 10
        view.layer.shadowColor =  #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1).cgColor
        view.layer.shadowRadius = 2.0
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        view.addSubview(cardTitle)
        updateViewConstraints()
        
    }
    
    
    
    override  func updateViewConstraints() {
        let margins = view.layoutMarginsGuide
        
        cardTitle.topAnchor.constraint(equalTo: margins.topAnchor, constant: 12).isActive = true
        cardTitle.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 50).isActive = true
        
        super.updateViewConstraints()
    }
    
}// end
