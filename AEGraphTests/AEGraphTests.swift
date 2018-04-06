//
//  AEGraphTests.swift
//  AEGraphTests
//
//  Created by Allan Evans on 3/4/18.
//  Copyright © 2018 Aelyssum Corp. All rights reserved.
//

import XCTest
@testable import AEGraph

class AEGraphTests: XCTestCase {
    
    class Node: Hashable, Equatable, CustomDebugStringConvertible {
        var id: String
        
        init(_ id: String) {
            self.id = id
        }
        
        var hashValue: Int {
            return id.hashValue
        }
        
        static func ==(lhs: Node, rhs: Node) -> Bool {
            return lhs.id == rhs.id
        }
        
        var debugDescription: String {
            return "Node \(id)"
        }
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testKevinDrumm() {
        let nodeA = Node("A")
        let nodeB = Node("B")
        let nodeC = Node("C")
        let nodeD = Node("D")
        let nodeE = Node("E")

        let vertices = [
            nodeA,
            nodeB,
            nodeC,
            nodeD,
            nodeE
        ]
        
        let edges = [
            AEGraph.Edge(from: nodeA, to: nodeB, withCost: 6.0),
            AEGraph.Edge(from: nodeA, to: nodeD, withCost: 1.0),
            AEGraph.Edge(from: nodeB, to: nodeC, withCost: 5.0),
            AEGraph.Edge(from: nodeB, to: nodeD, withCost: 2.0),
            AEGraph.Edge(from: nodeB, to: nodeE, withCost: 2.0),
            AEGraph.Edge(from: nodeC, to: nodeE, withCost: 5.0),
            AEGraph.Edge(from: nodeD, to: nodeE, withCost: 1.0)
        ]
        
        let graph = AEGraph(
            vertices: vertices,
            edges: edges
        )
        let path = graph.calculateShortestPaths(from: nodeA, to: nodeC)
        let expectedCost = 7.0
        XCTAssert(path.cost == expectedCost, "Got \(path.cost), expected \(expectedCost)")
        let expectedVertices = [nodeA, nodeD, nodeE]
        XCTAssert(path.vertices == expectedVertices, "Path.vertices failure:  Got \(path.vertices), expected \(expectedVertices)")
    }
    
    func testBarngrader() {
        let nodeA = Node("A")
        let nodeB = Node("B")
        let nodeC = Node("C")
        let nodeD = Node("D")
        let nodeE = Node("E")
        let nodeF = Node("F")
        let nodeG = Node("G")
        let nodeH = Node("H")

        let vertices = [
            nodeA,
            nodeB,
            nodeC,
            nodeD,
            nodeE,
            nodeF,
            nodeG,
            nodeH
        ]
        
        let edges = [
            AEGraph.Edge(from: nodeA, to: nodeB, withCost: 8.0),
            AEGraph.Edge(from: nodeA, to: nodeC, withCost: 2.0),
            AEGraph.Edge(from: nodeB, to: nodeD, withCost: 2.0),
            AEGraph.Edge(from: nodeB, to: nodeF, withCost: 13.0),
            AEGraph.Edge(from: nodeC, to: nodeD, withCost: 2.0),
            AEGraph.Edge(from: nodeC, to: nodeE, withCost: 5.0),
            AEGraph.Edge(from: nodeD, to: nodeE, withCost: 1.0),
            AEGraph.Edge(from: nodeD, to: nodeF, withCost: 6.0),
            AEGraph.Edge(from: nodeD, to: nodeG, withCost: 3.0),
            AEGraph.Edge(from: nodeE, to: nodeG, withCost: 1.0),
            AEGraph.Edge(from: nodeF, to: nodeG, withCost: 2.0),
            AEGraph.Edge(from: nodeF, to: nodeH, withCost: 3.0),
            AEGraph.Edge(from: nodeG, to: nodeH, withCost: 6.0)
        ]
        
        let graph = AEGraph(
            vertices: vertices,
            edges: edges
        )
        let path = graph.calculateShortestPaths(from: nodeA, to: nodeH)
        let expectedCost = 11.0
        XCTAssert(path.cost == expectedCost, "Got \(path.cost), expected \(expectedCost)")
        let expectedVertices = [nodeA, nodeC, nodeD, nodeE, nodeG, nodeF]
        XCTAssert(path.vertices == expectedVertices, "Path.vertices failure:  Got \(path.vertices), expected \(expectedVertices)")
    }

}
