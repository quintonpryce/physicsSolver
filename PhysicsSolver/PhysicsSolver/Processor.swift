//
//  Processor.swift
//  PhysicsSolver
//
//  Created by Quinton Pryce on 2018-11-10.
//  Copyright © 2018 Quinton Pryce. All rights reserved.
//

import Foundation

// which functions to ignore in the process args, this value gets reset on every calculation of a variable to then look at what we can calculate with the new set of solved variables

class Processor {
    
    var ignore: [String] = []
    let equations: [String: (String, [String: Double]) -> Formula?]
    
    init(equations: [String: (String, [String: Double]) -> Formula?]){
        self.equations = equations
    }
    
    // preforms the processing of arguments (variables) it tries to compute our result with all the equations
    func processArgs(result: String, args: [String: Double]) -> Double {
        for (key, equation) in equations {
            if key.contains(result) && !ignore.contains(key) {
                ignore.append(key)
                let result = preform(formula: equation(result, args), for: result, with: args)
                
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
    func preform(formula: Formula?, for result: String, with args: [String: Double]) -> Double {
        print("Preforming variables: \(String(describing: formula?.variables)), result: \(result)")
        guard let formula = formula else { return 0.0 }
        
        for variable in formula.variables {
            if args[variable] == nil {
                return reprocess(variable: variable, for: result, with: args)
            }
        }
        ignore.removeAll()
        return formula.equation(args)
    }

    
}
