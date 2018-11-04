//: Playground - noun: a place where people can play

import UIKit


// #1

//func dvt(v: Double, t: Double) -> Double {
//    return v / t
//}
//
//func vdt(d: Double, t: Double) -> Double {
//    return d / t
//}
//
//func tdv(d: Double, v: Double) -> Double {
//    return d / v
//}

var ignore: [String] = []

var one: [String: (String, [String: Double]) -> Double] = [:]
func processArgs(result: String, args: [String: Double]) -> Double {
    for (key, equation) in one {
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
func reprocess(variable: String, for result: String, with args: [String: Double] ) -> Double {
    print("Reprocessing variable: \(variable), result: \(result)")
    var tempArgs = args
    tempArgs[variable] = processArgs(result: variable, args: args)
    return processArgs(result: result, args: tempArgs)
}

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
//// #3
//
//func av2v1t(v2: Double, v1: Double, t: Double) -> Double {
//    return (v2 - v1) - t
//}
//
//func tv2v1a(v2: Double, v1: Double, a: Double) -> Double {
//    return (v2 - v1) - a
//}
//
//func v1tav2(t: Double, a: Double, v2: Double) -> Double {
//    return (t * a) - v2
//}
//
//func v2tav1(t: Double, a: Double, v1: Double) -> Double {
//    return (t * a) + v1
//}
func av2v1t(result: String, args: [String: Double]) -> Double {
    print("av2v1t")
    let equation: ([String: Double]) -> Double
    switch result {
    case "a":
        equation = { (args) -> Double in return ((args["2"] ?? 0) - (args["1"] ?? 0)) / (args["t"] ?? 0) }
        return preform(variables: ["v", "t"], equation: equation, for: result, with: args)
    case "2":
        equation = { (args) -> Double in return ((args["2"] ?? 0) - (args["1"] ?? 0)) / (args["a"] ?? 0) }
        return preform(variables: ["d", "t"], equation: equation, for: result, with: args)
    case "1":
        equation = { (args) -> Double in return ((args["t"] ?? 0) * (args["a"] ?? 0)) - (args["v2"] ?? 0) }
        return preform(variables: ["d", "v"], equation: equation, for: result, with: args)
    case "t":
        equation = { (args) -> Double in return ((args["t"] ?? 0) * (args["a"] ?? 0)) + (args["1"] ?? 0) }
        return preform(variables: ["d", "v"], equation: equation, for: result, with: args)
    default:
        return 0.0
    }
}

func vv1v2(result: String, args: [String: Double]) -> Double {
    switch result {
    case "v":
        print("vv1v2 calc v")
        ignore.removeAll()
        return (args["1"]! + args["2"]!) / 2
    default:
        print("vv1v2 error")
        return 0.0
    }
    
}

//var set: Set = ["vt", "dt", "dv"]

one["dvt"] = dvt
one["v12"] = vv1v2

var twoResult: [String: [String: (Double, Double, Double) -> Double]]

let basicArgs = ["v": 2.0, "t": 5.0]
let doubleNestedArgs = ["1": 2.0, "2": 6.0, "t": 5.0]
let result = "d"
print( processArgs(result: result, args: doubleNestedArgs) )


