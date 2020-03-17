//
//  CustomTableCell.swift
//  abel6000_a4
//
//  Created by Adriana Abella on 2020-03-01.
//  Copyright © 2020 wlu. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var fruitPic: UIImageView!
    
    @IBOutlet weak var fruitTitle: UILabel!
    
    @IBOutlet weak var fruitLikes: UILabel!
    
    @IBOutlet weak var fruitDislikes: UILabel!
    
    func setFruit(fruit: Fruit) {
        fruitPic.image = fruit.fruitImage
        fruitTitle.text = fruit.fruitName
        fruitDislikes.text = String(fruit.dislikes)
        fruitLikes.text = String(fruit.likes)
     }
}
