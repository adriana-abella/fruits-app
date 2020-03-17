//
//  FruitCollection.swift
//  abel6000_a2
//
//  Created by Adriana Abella on 2020-01-29.
//  Copyright © 2020 wlu. All rights reserved.
//
import Foundation
import UIKit

class FruitCollection: NSObject, NSCoding {
    var collection = [Fruit]() // a collection is an array of fruits
    var current:Int = 0 // the current  fruit in the collection (to be shown in the scene)

    let collectionKey = "collectionKey"
    let currentKey   = "currentKey"
    
    //NSCoding Methods
    
    override init(){
        super.init()
        setup()
    }
    
    required convenience init?(coder decoder: NSCoder){
    self.init()
    collection = (decoder.decodeObject(forKey:collectionKey) as? [Fruit])!
    current = (decoder.decodeInteger(forKey: currentKey))
    }
    
    func encode(with acoder: NSCoder){
    acoder.encode(collection, forKey: collectionKey)
    acoder.encode(current, forKey: currentKey)
    }
    
func setup(){
    self.collection.append(Fruit(fruitName: "apple", fruitImage: UIImage(named: "apple")!, likes: 0, dislikes: 0)!)
    self.collection.append(Fruit(fruitName: "banana", fruitImage: UIImage(named: "banana")!, likes: 0, dislikes: 0)!)
    self.collection.append(Fruit(fruitName: "mango", fruitImage: UIImage(named: "mango")!, likes: 0, dislikes: 0)!)
    self.collection.append(Fruit(fruitName: "orange", fruitImage: UIImage(named: "orange")!, likes: 0, dislikes: 0)!)
}
    func getCount() -> Int {
        return self.collection.count
    }
    
    func getCollection() -> [Fruit] {
        return self.collection
    }
    
    func getFruitAtIndex(index: Int) -> Fruit {
        return self.collection[index]
    }
    
    func removeFruitAtIndex(index: Int){
        self.collection.remove(at: index)
    }
    
    func getFruitPic() -> UIImage{
        return self.collection[self.current].fruitImage
    }
    
    func getFruitLabel() -> String {
        return self.collection[self.current].fruitName
    }
    
    func getFruitLikes() -> Int{
        return self.collection[self.current].likes
    }
    
    func getFruitDislikes() -> Int{
        return self.collection[self.current].dislikes
    }
    
    func plusLikes() {
        let fruit = self.collection[self.current]
        fruit.likes = fruit.likes + 1
    }
    
    func plusDislikes() {
        let fruit = self.collection[self.current]
        fruit.dislikes = fruit.dislikes + 1
    }
    
    func currentFruit() -> Fruit {
        let fruit = self.collection[self.current]
        return fruit
    }
    
    func setCurrentIndex(to index: Int){
        self.current = index
    }
    
    func getCurrentIndex() -> Int {
        return self.current
    }
    
    func addFruit(fruit: Fruit) {
        self.collection.append(fruit)
    }
    
    func deleteFruit(fruit : Fruit) {
        if let index = self.collection.firstIndex(of: fruit) {
            self.collection.remove(at: index)
        }
    }
    

}
