//
//  AEGraph+Dijkstra.swift
//  AEGraph
//
//  Created by Allan Evans on 3/4/18.
//  Copyright © 2018 Aelyssum Corp. All rights reserved.
//

import Foundation

extension AEGraph {
    
    class Path {
        var cost: Double
        var vertices = [Element]()
        
        init() {
            cost = Double.greatestFiniteMagnitude
        }
        
        init(cost: Double) {
            self.cost = cost
        }
    }
    
    func min(lhs: Path, rhs: Path) -> Path {
        if lhs.cost < rhs.cost {
            return lhs
        } else {
            return rhs
        }
    }
    
    func calculateShortestPaths(from virtex1: Element) -> [Element:Path] {
        
        // Initialize paths, so paths to all elements have cost Double.max and paths to virtex1 is 0.
        var paths = [Element: Path]()
        for element in vertices.keys {
            paths[element] = Path()
        }
        paths[virtex1] = Path(cost: 0.0)

        var unvisitedVertices: Set<Element> = Set(vertices.keys)

        func minPath() -> (Element,Path) {
            var minCostPath = Path()
            var minCostVertex: Element?
            for vertex in unvisitedVertices {
                let path = paths[vertex]!
                if path.cost <= minCostPath.cost {
                    minCostPath = path
                    minCostVertex = vertex
                }
            }
            return (minCostVertex!,minCostPath)
        }
        while !unvisitedVertices.isEmpty {
            // Find element with minimum path
            print("Unvisited vertices: \(unvisitedVertices)")
            let (minimumCostVertex, minimumCostPath) = minPath()
            print("-- Minimum cost vertex: \(minimumCostVertex)")
            print("-- Minimum cost path: \(minimumCostPath.cost)")
            let edges = vertices[minimumCostVertex]!.edges
            print("-- Evaluating \(edges.count) edges...")
            for edge in edges {
                let vertex = edge.vertex
                guard unvisitedVertices.contains(vertex) else {
                    continue
                }
                print("---- Evaluating unvisited vertex \(vertex)")
                let path = paths[vertex]!
                if minimumCostPath.cost + edge.cost < path.cost {
                    path.vertices = minimumCostPath.vertices
                    path.vertices.append(minimumCostVertex)
                    path.cost = minimumCostPath.cost + edge.cost
                    print("---- Updating vertex \(vertex) with cost \(path.cost)")
                }
            }
            unvisitedVertices.remove(minimumCostVertex)
        }
        return paths
    }
    
    func calculateShortestPaths(from virtex1: Element, to vertex2: Element) -> Path {
        
        guard let _ = vertices[virtex1], let _ = vertices[vertex2] else {
            return Path(cost: 0.0)
        }
        return calculateShortestPaths(from: virtex1)[vertex2]!
    }
    
}


