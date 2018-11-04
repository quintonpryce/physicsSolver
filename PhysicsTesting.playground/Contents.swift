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
var one: [String: (String, [String: Double]) -> Double] = [:]
func processArgs(result: String, args: [String: Double]) -> Double {
    for (key, equation) in one {
        if key.contains(result) {
            let result = equation(result, args)
            if result != 0.0 {
                return result
            }
        }
    }
    return -1.0
}
func reprocess(value: String, for result: String, with args: [String: Double] ) -> Double {
    var tempArgs = args
    tempArgs[value] = processArgs(result: value, args: args)
    return processArgs(result: result, args: tempArgs)
}

func preform(variables: [String], equation: ([String: Double]) -> Double, for result: String, with args: [String: Double]) -> Double {
    for variable in variables {
        if args[variable] == nil {
            return reprocess(value: variable, for: result, with: args)
        }
    }
    return equation(args)
}

func dvt(result: String, args: [String: Double]) -> Double {
    switch result {
    case "d":
        if let v = args["v"], let t = args["t"] {
            return v / t
        } else if args["v"] == nil {
            return reprocess(value: "v", for: "d", with: args)
        } else if args["t"] == nil {
            return reprocess(value: "t", for: "d", with: args)
        } else {
            return 0.0
        }
    case "v":
        if let d = args["d"], let t = args["t"] {
            return d / t
        } else if args["d"] == nil {
            return reprocess(value: "d", for: "v", with: args)
        } else if args["t"] == nil {
            return reprocess(value: "t", for: "v", with: args)
        } else {
            return 0.0
        }
        
    case "t":
        if let d = args["d"], let v = args["v"] {
            return d / v
        } else if args["d"] == nil {
            return reprocess(value: "d", for: "t", with: args)
        } else if args["v"] == nil {
            return reprocess(value: "v", for: "t", with: args)
        } else {
            return 0.0
        }
    default:
        return 0.0
    }
    
}

func vv1v2(result: String, args: [String: Double]) -> Double {
    switch result {
    case "v":
        return (args["1"]! + args["2"]!) / 2
    default:
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
//one["v"]?(1.0, 3.0)



//
//
//func vdt(args: [String: Double]) -> Double {
//    return args["d"]! / args["t"]!
//}
//
//func tdv(args: [String: Double]) -> Double {
//    return args["d"]! / args["v"]!
//}
//
//// #2
//
//func dv1v2t(v1: Double, v2: Double, t: Double) -> Double {
//    return (v1 + v2) / 2 * t
//}
//
//func v1dv2t(d: Double, v2: Double, t: Double) -> Double {
//    return (t / 2 * d) - v2
//}
//
//func v2v1dt(v1: Double, d: Double, t: Double) -> Double {
//    return (t / 2 * d) - v1
//}
//
//func tv1v2d(v1: Double, v2: Double, d: Double) -> Double {
//    return 2 * d / (v1 + v2)
//}
//
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
