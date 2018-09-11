//
//  SubItemView.swift
//  DynamicStackViewTest
//
//  Created by Adam Teale on 9/10/18.
//  Copyright © 2018 Adam Teale. All rights reserved.
//

import UIKit

enum SubItemType: Int {
    case warning = 0
    case success
    case rejected
    
    var description: String{
        switch self {
        case .rejected:
            return "rejected"
        case .success:
            return "success"
        case .warning:
            return "warning"
        }
    }
    
    var colour: UIColor {
        switch self {
        case .rejected:
            return .init(red: 0.9, green: 0.9, blue: 0.8, alpha: 1.0)
        case .success:
            return .init(red: 0.7, green: 0.7, blue: 0.8, alpha: 1.0)
        case .warning:
            return .init(red: 0.8, green: 0.7, blue: 0.6, alpha: 1.0)
        }
    }
    
    var image: UIImage?{
        switch self {
        case .success:
            return UIImage(named: "harvest")
        default:
            return UIImage(named: "NGC-6188-V1")
        }
    }
}


struct SubItem {
    let name: String
    let age: Int
    let type: SubItemType
}


class SubItemView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var subItem: SubItem?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    convenience init(withSubItem item: SubItem?){
        self.init()
        self.subItem = item
        if subItem != nil {
            self.mainLabel.text = subItem?.name
        }
        self.contentView.backgroundColor = self.subItem!.type.colour
        self.typeLabel.text = self.subItem!.type.description
        if let subItem = self.subItem, let img = subItem.type.image{
            self.imageView.image = img
        }
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("SubItemView", owner: self, options: nil)
        addSubview(contentView)
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }

}
