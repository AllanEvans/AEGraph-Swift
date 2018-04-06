//
//  AEGraph.swift
//  AEGraph
//
//  Created by Allan Evans on 3/4/18.
//  Copyright © 2018 Aelyssum Corp. All rights reserved.
//

import Foundation

class AEGraph<Element: Hashable> {
    
    var vertices = [Element: Vertex]()
    var isDirected: Bool = false
    
    class Vertex {
        var edges = Set<_Edge>()
        
        func addEdge(to vertex: Element, withCost cost: Double) {
            edges.insert(_Edge(vertex: vertex, cost: cost))
        }
        
        var degree: Int {
            return edges.count
        }
        
    }

    class _Edge: Hashable, Equatable {
        var vertex: Element
        var cost: Double
        
        init(vertex: Element, cost: Double) {
            self.vertex = vertex
            self.cost = cost
        }
        
        var hashValue: Int {
            return vertex.hashValue
        }
        
        static func ==(lhs: _Edge, rhs: _Edge) -> Bool {
            return lhs.vertex == rhs.vertex
        }
        
        func contains(_ set: Set<Element>) -> Bool {
            return set.contains(vertex)
        }
        
    }
    
    struct Edge {
        var vertex1: Element
        var vertex2: Element
        var cost: Double
        
        init(from vertex1: Element, to vertex2: Element, withCost cost: Double = 1.0) {
            self.vertex1 = vertex1
            self.vertex2 = vertex2
            self.cost = cost
        }
    }
    
    init(vertices: [Element], edges: [Edge], isDirected: Bool) {
        self.isDirected = isDirected
        add(vertices)
        add(edges)
    }

    func add(_ vertices: [Element]) {
        for vertex in vertices {
            self.vertices[vertex] = Vertex()
        }
    }
    
    func add(_ edges: [Edge]) {
        for edge in edges {
            if let vertex1 = vertices[edge.vertex1] {
                vertex1.addEdge(to: edge.vertex2, withCost: edge.cost)
            }
            if let vertex2 = vertices[edge.vertex2], !isDirected {
                vertex2.addEdge(to: edge.vertex1, withCost: edge.cost)
            }
        }
    }
    
    func degree(of element: Element) -> Int {
        guard let virtex = vertices[element] else {
            return 0
        }
        return virtex.degree
    }
}
