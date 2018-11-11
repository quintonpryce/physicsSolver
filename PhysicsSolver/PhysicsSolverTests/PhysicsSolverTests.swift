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

    var processor: Processor = Processor(equations: [:])
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
        var value: Double
        
        value = processor.processArgs(result: "v", args: ["d": 680.0, "t": 8.0])
        XCTAssert( value == 85.0, "\(value) did not = 85.0" )
        
        value = processor.processArgs(result: "t", args: ["d": 235.0, "v": 30.0])
        XCTAssert( value == 7.833333333333333, "\(value) did not = 7.8333333333333" )
        
        value = processor.processArgs(result: "d", args: ["1": 30.0, "2": 0.0, "t": 6.0])
        XCTAssert( value == 90.0, "\(value) did not = 90.0")
    }
    
    func testBasicAccelerationKinematics() {
        var value: Double
        
        let v1 = 22.2222
        let a = -1.5
        let v2 = 0.0
        
        value = processor.processArgs(result: "d", args: ["1": v1, "a": a, "2": v2])
        XCTAssert( value.rounded() == 165, "\(value) did not = 165" )

        value = processor.processArgs(result: "t", args: ["1": v1, "a": a, "2": v2])
        XCTAssert( value.rounded() == 15, "\(value) did not = 15" )
    }
    
    func testBasicGravityKinematics() {
        var value: Double
        
        let v1 = 24.0
        let a = -9.8
        let v2 = 0.0
        
        value = processor.processArgs(result: "d", args: ["1": v1, "a": a, "2": v2])
        XCTAssert( value.rounded() == 29, "\(value) did not = 29.0" )
        
        // up and then down time of ball
        value = processor.processArgs(result: "t", args: ["1": v1, "a": a, "2": v2])
        value = value + processor.processArgs(result: "t", args: ["1": 0.0, "a": a, "d": -29.0])
        XCTAssert( value.rounded() == 5, "\(value) did not = 5" )
        
    }
    
    func testBasicRecurssiveKinematics() {
        let value = processor.processArgs(result: "d", args: ["1": 2.0, "2": 6.0, "t": 20.0])
        XCTAssert( value.rounded() == 80, "\(value) did not = 80" )
    }
    
    func testNoAnswer() {
       XCTAssert( processor.processArgs(result: "d", args: ["1": 2.0]) == 0.0)
    }

}
