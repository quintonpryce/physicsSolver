//
//  Kinematics.swift
//  PhysicsSolver
//
//  Created by Quinton Pryce on 2018-11-10.
//  Copyright © 2018 Quinton Pryce. All rights reserved.
//

import Foundation

class Kinematics {
    
    // Equation d = v/t
    func dvt(result: String, args: [String: Double]) -> Formula? {
        print("dvt")
        switch result {
        case "d":
            return Formula(variables: ["v", "t"], equation: { (args) -> Double in return (args["v"] ?? 0) / (args["t"] ?? 1) })
        case "v":
            return Formula(variables: ["d", "t"], equation: { (args) -> Double in return (args["d"] ?? 0) / (args["t"] ?? 1) })
        case "t":
            return Formula(variables: ["d", "v"], equation: { (args) -> Double in return (args["d"] ?? 0) / (args["v"] ?? 1) })
        default:
            return nil
        }
        
    }
    
    // Equation a = (v2 - v1) / t
    func av2v1t(result: String, args: [String: Double]) -> Formula? {
        print("av2v1t")
        switch result {
        case "a":
            return Formula(variables: ["2", "1", "t"], equation: { (args) -> Double in return ((args["2"] ?? 0) - (args["1"] ?? 0)) / (args["t"] ?? 0) })
        case "2":
            return Formula(variables: ["2", "1", "a"], equation: { (args) -> Double in return ((args["2"] ?? 0) - (args["1"] ?? 0)) / (args["a"] ?? 0) })
        case "1":
            return Formula(variables: ["t", "a", "2"], equation: { (args) -> Double in return ((args["t"] ?? 0) * (args["a"] ?? 0)) - (args["2"] ?? 0) })
        case "t":
            return Formula(variables: ["t", "a", "1"], equation: { (args) -> Double in return ((args["t"] ?? 0) * (args["a"] ?? 0)) + (args["1"] ?? 0) })
        default:
            return nil
        }
    }
    
    // Equation v = (v1 + v2) / 2
    func vv1v2(result: String, args: [String: Double]) -> Formula? {
        print("vv1v2")
        switch result {
        case "v":
            return Formula(variables: ["1, 2"], equation: { (args) -> Double in return ((args["1"] ?? 0) + (args["2"] ?? 0)) / 2 })
        case "1":
            return Formula(variables: ["v", "1"], equation: { (args) -> Double in return (2 * (args["v"] ?? 0)) - (args["1"] ?? 0) })
        case "2":
            return Formula(variables: ["v", "2"], equation: { (args) -> Double in return (2 * (args["v"] ?? 0)) - (args["2"] ?? 0) })
        default:
            return nil
        }
        
    }
    
    // Equation v2 = v1 + a * t
    func v2v1at(result: String, args: [String: Double]) -> Formula? {
        print("v2v1at")
        switch result {
        case "2":
            return Formula(variables: ["1", "a", "t"], equation: { (args) -> Double in return ((args["1"] ?? 0) + ((args["a"] ?? 0) * (args["t"] ?? 0))) / 2 })
        case "1":
            return Formula(variables: ["2", "a", "t"], equation: { (args) -> Double in return (args["2"] ?? 0) - ((args["a"] ?? 0) * (args["t"] ?? 0)) })
        case "a":
            return Formula(variables: ["2", "1", "t"], equation: { (args) -> Double in return ((args["2"] ?? 0) - (args["1"] ?? 0)) / (args["t"] ?? 1) })
        case "t":
            return Formula(variables: ["2", "1", "a"], equation: { (args) -> Double in return ((args["2"] ?? 0) - (args["1"] ?? 0)) / (args["a"] ?? 1) })
        default:
            return nil
        }
        
    }
    
    // Equation d = 1/2 * a * t^2
    func dat(result: String, args: [String: Double]) -> Formula? {
        print("dat")
        switch result {
        case "d":
            return Formula(variables: ["a", "t"], equation: { (args) -> Double in return (args["a"] ?? 0) * pow((args["t"] ?? 0), 2) / 2 })
        case "a":
            return Formula(variables: ["d", "t"], equation: { (args) -> Double in return (args["d"] ?? 0) * 2 / pow((args["t"] ?? 1), 2) })
        case "t":
            return Formula(variables: ["d", "a"], equation: { (args) -> Double in return pow(2 * (args["d"] ?? 0) / (args["a"] ?? 1), 1/2) })
        default:
            return nil
        }
    
    }
    
    // Equation v2 = sqrt(v1^2 + 2 * a * d)
    func v2v1ad(result: String, args: [String: Double]) -> Formula? {
        print("21ad")
        switch result {
        case "2":
            return Formula(variables: ["1", "a", "d"], equation: { (args) -> Double in return pow(pow((args["1"] ?? 0), 2) + (2 * (args["a"] ?? 0) * (args["d"] ?? 0)), 1/2) })
        case "1":
            return Formula(variables: ["2", "a", "d"], equation: { (args) -> Double in return pow(pow((args["2"] ?? 0), 2) - (2 * (args["a"] ?? 0) * (args["d"] ?? 0)), 1/2) })
        case "a":
            return Formula(variables: ["2", "1", "d"], equation: { (args) -> Double in return (pow((args["2"] ?? 0), 2) - pow((args["1"] ?? 0), 2)) / (2 * (args["d"] ?? 1)) })
        case "d":
            return Formula(variables: ["2", "1", "a"], equation: { (args) -> Double in return (pow((args["2"] ?? 0), 2) - pow((args["1"] ?? 0), 2)) / (2 * (args["a"] ?? 1)) })
        default:
            return nil
        }
        
    }
    
    // Equation d = v1 * t + 1/2 * a * t^2
    func d1tat(result: String, args: [String: Double]) -> Formula? {
        print("d1tat")
        switch result {
        case "d":
            return Formula(variables: ["1", "a", "t"], equation: { (args) -> Double in
                let firstHalf = ((args["1"] ?? 0) * (args["t"] ?? 0))
                let secondHalf = ((args["a"] ?? 0) * pow((args["t"] ?? 0), 2) / 2)
                return firstHalf + secondHalf })
        case "1":
            return Formula(variables: ["d", "a", "t"], equation: { (args) -> Double in
                let firstHalf = ((args["d"] ?? 0) - ((args["a"] ?? 0) * pow((args["t"] ?? 0), 2) / 2))
                return firstHalf / (args["t"] ?? 1) })
        case "a":
            return Formula(variables: ["2", "1", "d"], equation: { (args) -> Double in
                let firstHalf = ((args["d"] ?? 0) - ((args["1"] ?? 0) * (args["t"] ?? 0)))
                return firstHalf / (1/2 * pow((args["t"] ?? 1), 2)) })
        case "t":
            let first = (pow((args["1"] ?? 0), 2) + (2 * (args["a"] ?? 0) * (args["d"] ?? 0))).squareRoot()
            return Formula(variables: ["d", "1", "a"], equation: { (args) -> Double in
                let t1 = (-(args["1"] ?? 0) + first) / (args["a"] ?? 1)
                let t2 = (-(args["1"] ?? 0) - first) / (args["a"] ?? 1)
                return t1 >= t2 ? t1 : t2
            })
        default:
            return nil
        }
        
    }
}
