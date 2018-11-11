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

//// Equation a = (v2 - v1) / t
//func av2v1t(result: String, args: [String: Double]) -> Double {
//    print("av2v1t")
//    let equation: ([String: Double]) -> Double
//    switch result {
//    case "a":
//        equation = { (args) -> Double in return ((args["2"] ?? 0) - (args["1"] ?? 0)) / (args["t"] ?? 0) }
//        return preform(variables: ["2", "1", "t"], equation: equation, for: result, with: args)
//    case "2":
//        equation = { (args) -> Double in return ((args["2"] ?? 0) - (args["1"] ?? 0)) / (args["a"] ?? 0) }
//        return preform(variables: ["2", "1", "a"], equation: equation, for: result, with: args)
//    case "1":
//        equation = { (args) -> Double in return ((args["t"] ?? 0) * (args["a"] ?? 0)) - (args["2"] ?? 0) }
//        return preform(variables: ["t", "a", "2"], equation: equation, for: result, with: args)
//    case "t":
//        equation = { (args) -> Double in return ((args["t"] ?? 0) * (args["a"] ?? 0)) + (args["1"] ?? 0) }
//        return preform(variables: ["t", "a", "1"], equation: equation, for: result, with: args)
//    default:
//        return 0.0
//    }
//}

// Equation v = (v1 + v2) / 2
func vv1v2(result: String, args: [String: Double]) -> Double {
    print("vv1v2")
    let equation: ([String: Double]) -> Double
    switch result {
    case "v":
        equation = { (args) -> Double in return ((args["1"] ?? 0) + (args["2"] ?? 0)) / 2 }
        return preform(variables: ["1", "2"], equation: equation, for: result, with: args)
    case "1":
        equation = { (args) -> Double in return (2 * (args["v"] ?? 0)) - (args["1"] ?? 0) }
        return preform(variables: ["v", "1"], equation: equation, for: result, with: args)
    case "2":
        equation = { (args) -> Double in return (2 * (args["v"] ?? 0)) - (args["2"] ?? 0) }
        return preform(variables: ["v", "2"], equation: equation, for: result, with: args)
    default:
        return 0.0
    }
    
}

// Equation v2 = v1 + a * t
func v2v1at(result: String, args: [String: Double]) -> Double {
    print("v2v1at")
    switch result {
    case "2":
        guard let v1 = args["1"], let a = args["a"], let t = args["t"] else { return 0.0 }
        return preform(variables: ["1", "a", "t"], equation: { (args) -> Double in return (v1 + (a * t)) / 2 }, for: result, with: args)
    case "1":
        guard let v2 = args["2"], let a = args["a"], let t = args["t"] else { return 0.0 }
        return preform(variables: ["2", "a", "t"], equation: { (args) -> Double in return v2 - (a * t) }, for: result, with: args)
    case "a":
        guard let v2 = args["2"], let v1 = args["1"], let t = args["t"] else { return 0.0 }
        return preform(variables: ["2", "1", "t"], equation: { (args) -> Double in return (v2 - v1) / t }, for: result, with: args)
    case "t":
        guard let v2 = args["2"], let v1 = args["1"], let a = args["a"] else { return 0.0 }
        return preform(variables: ["2", "1", "a"], equation: { (args) -> Double in return (v2 - v1) / a }, for: result, with: args)
    default:
        return 0.0
    }
    
}

// Equation d = 1/2 * a * t^2
//func dat(result: String, args: [String: Double]) -> Double {
//    print("dat")
//    switch result {
//    case "d":
//        guard let a = args["a"], let t = args["t"] else { return 0.0 }
//        return preform(variables: ["a", "t"], equation: { (args) -> Double in return a * pow(t, 2) / 2 }, for: result, with: args)
//    case "a":
//        guard let d = args["d"], let t = args["t"] else { return 0.0 }
//        return preform(variables: ["d", "t"], equation: { (args) -> Double in return d * 2 / pow(t, 2) }, for: result, with: args)
//    case "t":
//        guard let d = args["d"], let a = args["a"] else { return 0.0 }
//        return preform(variables: ["d", "a"], equation: { (args) -> Double in return pow(2 * d / a, 1/2) }, for: result, with: args)
//    default:
//        return 0.0
//    }
//
//}

// Equation v2 = sqrt(v1^2 + 2 * a * d)
func v2v1ad(result: String, args: [String: Double]) -> Double {
    print("21ad")
    switch result {
    case "2":
        guard let v1 = args["1"], let a = args["a"], let d = args["d"] else { return 0.0 }
        return preform(variables: ["1", "a", "d"], equation: { (args) -> Double in return pow(pow(v1, 2) + (2 * a * d), 1/2) }, for: result, with: args)
    case "1":
        guard let v2 = args["2"], let a = args["a"], let d = args["d"] else { return 0.0 }
        return preform(variables: ["2", "a", "d"], equation: { (args) -> Double in return pow(pow(v2, 2) - (2 * a * d), 1/2) }, for: result, with: args)
    case "a":
        guard let v2 = args["2"], let v1 = args["1"], let d = args["d"] else { return 0.0 }
        return preform(variables: ["2", "1", "d"], equation: { (args) -> Double in return (pow(v2, 2) - pow(v1, 2)) / 2 * d }, for: result, with: args)
    case "d":
        guard let v2 = args["2"], let v1 = args["1"], let a = args["a"] else { return 0.0 }
        return preform(variables: ["2", "1", "a"], equation: { (args) -> Double in return (pow(v2, 2) - pow(v1, 2)) / 2 * a }, for: result, with: args)
    default:
        return 0.0
    }
    
}

// Equation d = v1 * t + 1/2 * a * t^2
func d1tat(result: String, args: [String: Double]) -> Double {
    print("d1tat")
    switch result {
    case "d":
        guard let v1 = args["1"], let a = args["a"], let t = args["t"] else { return 0.0 }
        return preform(variables: ["1", "a", "t"], equation: { (args) -> Double in return (v1 * t) + (a * pow(t, 2) / 2) }, for: result, with: args)
    case "1":
        guard let d = args["d"], let a = args["a"], let t = args["t"] else { return 0.0 }
        return preform(variables: ["d", "a", "t"], equation: { (args) -> Double in return (d - (a * pow(t, 2) / 2)) / t }, for: result, with: args)
    case "a":
        guard let d = args["d"], let v1 = args["1"], let t = args["t"] else { return 0.0 }
        return preform(variables: ["2", "1", "d"], equation: { (args) -> Double in return (d - (v1 * t)) / (1/2 * pow(t, 2)) }, for: result, with: args)
    case "t":
        guard let d = args["d"], let v1 = args["1"], let a = args["a"] else { return 0.0 }
        return preform(variables: ["d", "1", "a"], equation: { (args) -> Double in return (-v1 + (pow(pow(v1, 2) + (2 * a * d), 1/2))) / a }, for: result, with: args)
    default:
        return 0.0
    }
    
}

equations["d1tat"] = d1tat
equations["21ad"] = v2v1ad
equations["21at"] = v2v1at
//equations["dat"] = dat
//equations["dvt"] = dvt
equations["v12"] = vv1v2
//equations["a21t"] = av2v1t

//let basicArgs = ["v": 2.0, "t": 5.0]
//let resultBasic = "d"
//let doubleNestedArgs = ["1": 2.0, "2": 6.0, "t": 5.0]
//let resultDouble = "d"
//let tripleNestedArgs = ["1": 2.0, "2": 6.0, "d": 20.0]
//let resultTriple = "a"
//print( processArgs(result: resultTriple, args: tripleNestedArgs) )
//print("ANEW")
//let calcAverageSpeed = ["d": 680.0, "t": 8.0]
//print( processArgs(result: "v", args: calcAverageSpeed) )
//print("ANEW")
//let calcTime = ["d": 235.0, "v": 30.0]
//print( processArgs(result: "t", args: calcTime) )
print(processArgs(result: "d", args: ["1": 30.0, "2": 0.0, "t": 6.0]))

