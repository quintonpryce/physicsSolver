//
//  PhysicsSolverTests.swift
//  PhysicsSolverTests
//
//  Created by Quinton Pryce on 2018-11-10.
//  Copyright © 2018 Quinton Pryce. All rights reserved.
//

import XCTest
@testable import PhysicsSolver

class PhysicsSolverTests: XCTestCase {

    var processor: Processor?
    var kinematics = Kinematics()
    override func setUp() {
        var equations: [String: (String, [String: Double]) -> Formula?] = [:]
        equations["d1tat"] = kinematics.d1tat
        equations["21ad"] = kinematics.v2v1ad
        equations["21at"] = kinematics.v2v1at
        //equations["dat"] = dat
        equations["dvt"] = kinematics.dvt
        equations["v12"] = kinematics.vv1v2
        
        processor = Processor(equations: equations)
        
    }

    func testBasicKinematics() {
//        XCTAssert( processor?.processArgs(result: "v", args: ["d": 680.0, "t": 8.0]) == 85.0, "\(processor?.processArgs(result: "v", args: ["d": 680.0, "t": 8.0]))" )
//        print("ANEW")
//        XCTAssert( processor?.processArgs(result: "t", args: ["d": 235.0, "v": 30.0]) == 7.833333333333333, "\(processor?.processArgs(result: "t", args: ["d": 235.0, "v": 30.0]))" )
//        print("ANEW")
        XCTAssert( processor?.processArgs(result: "d", args: ["1": 30.0, "2": 0.0, "t": 6.0]) == 90.0, "\(processor?.processArgs(result: "d", args: ["1": 30.0, "2": 0.0, "t": 6.0]))" )
    }

}
