//
//  Formula.swift
//  PhysicsSolver
//
//  Created by Quinton Pryce on 2018-11-10.
//  Copyright © 2018 Quinton Pryce. All rights reserved.
//

import Foundation

class Formula {
    let variables: [String]
    let equation: ([String: Double]) -> Double
    
    init(variables: [String], equation: @escaping ([String: Double]) -> Double) {
        self.variables = variables
        self.equation = equation
    }
}
