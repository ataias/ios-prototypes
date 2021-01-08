//
//  MyClass.swift
//  UnitTestingBasics
//
//  Created by Ataias Pereira Reis on 07/01/21.
//

import Foundation

class MyClass {
    private static var allInstances = 0
    private let instance: Int

    init() {
        MyClass.allInstances += 1
        instance = MyClass.allInstances
        print(">> \(#function) #\(instance)")
    }

    deinit {
        print(">> \(#function) \(instance)")
    }
    public func methodOne() {
        print(">> \(#function)")
    }

    func methodTwo() {
        print(">> \(#function)")
    }
}
