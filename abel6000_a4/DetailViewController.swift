//
//  ViewController.swift
//  abel6000_a2
//
//  Created by Adriana Abella on 2020-01-29.
//  Copyright © 2020 wlu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var dislikesLabel: UILabel!
    @IBOutlet weak var fruitLabel: UILabel!
    
    var sharedFruitCollection : FruitCollection?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sharedFruitCollection  = SharingFruitCollection.sharedFruitCollection.fruitCollection
        
        let fruit = sharedFruitCollection?.currentFruit()

        likesLabel.text = String(fruit!.getLikes())
        dislikesLabel.text = String(fruit!.getDislikes())
        imageView.image =  fruit!.getImage()
        fruitLabel.text = String(fruit!.getName())
    }
    
    @IBAction func dislikebuttonPressed(_ sender: Any) {
    
        sharedFruitCollection?.currentFruit().addDislikes()
        
        dislikesLabel.text = String(sharedFruitCollection!.currentFruit().getDislikes())
        
        print("The dislike button was pressed!")
    }
    
    @IBAction func likebuttonPressed(_ sender: Any) {
        
        sharedFruitCollection?.currentFruit().addLikes()
        
        likesLabel.text = String(sharedFruitCollection!.currentFruit().getLikes())
        
        print("The like button was pressed!")
        
    }
    
    
    @IBAction func nextbuttonPressed(_ sender: Any)
    {
        sharedFruitCollection?.setCurrentIndex(to: sharedFruitCollection!.getCurrentIndex()+1)

        let x = sharedFruitCollection!.getCurrentIndex()

        if x == (sharedFruitCollection!.collection.count - 1)
        {
            sharedFruitCollection!.setCurrentIndex(to: 0)
        }

        imageView.image = sharedFruitCollection!.currentFruit().getImage()
        likesLabel.text = String(sharedFruitCollection!.currentFruit().getLikes())
        dislikesLabel.text = String(sharedFruitCollection!.currentFruit().getDislikes())
        fruitLabel.text = String(sharedFruitCollection!.currentFruit().getName())

        UserDefaults.standard.set(sharedFruitCollection!.getCurrentIndex(), forKey: "currentIndex")
    }
    
}


