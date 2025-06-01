//
//  ViewController.swift
//  BanquitoScan
//
//  Created by Gaspar Dolcemascolo on 14-04-25.
//

import UIKit

class ViewController: UIViewController {
    var dogInstance: Dog?
    var ownerInstance: Owner?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        dogInstance = Dog(name: "Pancho", owner: nil)
        ownerInstance = Owner(name: "Gaspar", dog: nil)
        
        dogInstance?.owner = ownerInstance
        ownerInstance?.dog = dogInstance
        
        ownerInstance = nil
        dogInstance = nil
//        example1()
//        example2()
//        example3()
    }
    
//    func example1() {
//        var valueA: Int = 22
//        var valueB: Int = valueA
//        valueA = 25
//    }
//    
//    func example2() {
//        var valueA: ClassExample? = ClassExample()
//        var valueB: ClassExample? = valueA
//        valueB?.age = 25
//        
//        valueA = nil
//        valueB = nil
//    }
//    
//    func example3() {
//        var valueA = StructExample()
//        var valueB = valueA
//        valueB.age = 25
//    }
}

class ClassExample {
    var age: Int = 22
    
    deinit {
        print("se limpiara la memoria")
    }
}

struct StructExample {
    var age: Int = 22
}

class Dog {
    var name: String
    weak var owner: Owner?
    
    init(name: String, owner: Owner? = nil) {
        self.name = name
        self.owner = owner
    }
    
    deinit {
        print("DOG deinitialized")
    }
    
}

class Owner {
    var name: String
    weak var dog: Dog?
    
    init(name: String, dog: Dog? = nil) {
        self.name = name
        self.dog = dog
    }
    
    deinit {
        print("OWNER deinitialized")
    }
}
