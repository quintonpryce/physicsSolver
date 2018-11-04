//: Playground - noun: a place where people can play

import UIKit

// which functions to ignore in the process args, this value gets reset on every calculation of a variable to then look at what we can calculate with the new set of solved variables
var ignore: [String] = []

// holds reference to all of our equation's functions
var equations: [String: (String, [String: Double]) -> Double] = [:]

// preforms the processing of arguments (variables) it tries to compute our result with all the equations
func processArgs(result: String, args: [String: Double]) -> Double {
    for (key, equation) in equations {
        if key.contains(result) && !ignore.contains(key) {
            ignore.append(key)
            let result = equation(result, args)
            
            if result != 0.0 {
                return result
            }
        }
    }
    return 0.0
}

// recursivly called to reprocess variables that we don't have and then it tries to process the missing variable and returns it
func reprocess(variable: String, for result: String, with args: [String: Double] ) -> Double {
    print("Reprocessing variable: \(variable), result: \(result)")
    var tempArgs = args
    tempArgs[variable] = processArgs(result: variable, args: args)
    return processArgs(result: result, args: tempArgs)
}

// calls either reprocess to aquire the missing variables and when it finds a new variable it returns it
func preform(variables: [String], equation: ([String: Double]) -> Double, for result: String, with args: [String: Double]) -> Double {
    print("Preforming variables: \(variables), result: \(result)")
    for variable in variables {
        if args[variable] == nil {
            return reprocess(variable: variable, for: result, with: args)
        }
    }
    ignore.removeAll()
    return equation(args)
}

// MARK: - Equations
// The equations are methods that store each case of the respcted equation. They set up all the equation's possibilities for rearrangment.

// Equation d = v/t
func dvt(result: String, args: [String: Double]) -> Double {
    print("dvt")
    let equation: ([String: Double]) -> Double
    switch result {
    case "d":
        equation = { (args) -> Double in return (args["v"] ?? 0) / (args["t"] ?? 1) }
        return preform(variables: ["v", "t"], equation: equation, for: result, with: args)
    case "v":
        equation = { (args) -> Double in return (args["d"] ?? 0) / (args["t"] ?? 1) }
        return preform(variables: ["d", "t"], equation: equation, for: result, with: args)
    case "t":
        equation = { (args) -> Double in return (args["d"] ?? 0) / (args["v"] ?? 1) }
        return preform(variables: ["d", "v"], equation: equation, for: result, with: args)
    default:
        return 0.0
    }
    
}

// Equation a = (v2 - v1) / t
func av2v1t(result: String, args: [String: Double]) -> Double {
    print("av2v1t")
    let equation: ([String: Double]) -> Double
    switch result {
    case "a":
        equation = { (args) -> Double in return ((args["2"] ?? 0) - (args["1"] ?? 0)) / (args["t"] ?? 0) }
        return preform(variables: ["2", "1", "t"], equation: equation, for: result, with: args)
    case "2":
        equation = { (args) -> Double in return ((args["2"] ?? 0) - (args["1"] ?? 0)) / (args["a"] ?? 0) }
        return preform(variables: ["2", "1", "a"], equation: equation, for: result, with: args)
    case "1":
        equation = { (args) -> Double in return ((args["t"] ?? 0) * (args["a"] ?? 0)) - (args["2"] ?? 0) }
        return preform(variables: ["t", "a", "2"], equation: equation, for: result, with: args)
    case "t":
        equation = { (args) -> Double in return ((args["t"] ?? 0) * (args["a"] ?? 0)) + (args["1"] ?? 0) }
        return preform(variables: ["t", "a", "1"], equation: equation, for: result, with: args)
    default:
        return 0.0
    }
}

// Equation v = (v1 + v2) / 2
func vv1v2(result: String, args: [String: Double]) -> Double {
    let equation: ([String: Double]) -> Double
    switch result {
    case "v":
        print("vv1v2")
        equation = { (args) -> Double in return ((args["1"] ?? 0) + (args["2"] ?? 0)) / 2 }
        return preform(variables: ["1", "2"], equation: equation, for: result, with: args)
    default:
        print("vv1v2 error")
        return 0.0
    }
    
}

equations["dvt"] = dvt
equations["v12"] = vv1v2
equations["a21t"] = av2v1t

let basicArgs = ["v": 2.0, "t": 5.0]
let resultBasic = "d"
let doubleNestedArgs = ["1": 2.0, "2": 6.0, "t": 5.0]
let resultDouble = "d"
let tripleNestedArgs = ["1": 2.0, "2": 6.0, "d": 20.0]
let resultTriple = "a"
print( processArgs(result: resultTriple, args: tripleNestedArgs) )


