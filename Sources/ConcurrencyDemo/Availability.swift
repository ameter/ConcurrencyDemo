//
//  File.swift
//  
//
//  Created by Ameter, Chris on 8/18/22.
//

import Foundation

struct Geo {
    
    struct SearchForTextOptions {}
    struct SearchForCoordinatesOptions {}
    struct Place {}
    struct Coordinates {}
    struct MapStyle {}
    typealias ResultsHandler<Success> = (Success) -> Void
    
    func search(for text: String,
                options: Geo.SearchForTextOptions?) async throws -> [Geo.Place] {
        return [Geo.Place()]
    }
    
    func search(for coordinates: Geo.Coordinates,
                options: Geo.SearchForCoordinatesOptions?) async throws -> [Geo.Place] {
        
        return [Geo.Place()]
    }
    
    func availableMaps() async throws -> [Geo.MapStyle] {
        return [Geo.MapStyle()]
    }
    
    func defaultMap() async throws -> Geo.MapStyle {
        return Geo.MapStyle()
    }
    
}

// MARK: - Geo+Migration.swift

extension Geo {
    @available(*, unavailable, message: "Use search(for text: String, options: Geo.SearchForTextOptions?) async throws -> [Geo.Place]")
    func search(for text: String,
                options: Geo.SearchForTextOptions?,
                completionHandler: @escaping Geo.ResultsHandler<[Geo.Place]>) {}
    
    @available(*, unavailable, renamed: "query(byIdentifier:)")
    func search(for coordinates: Geo.Coordinates,
                options: Geo.SearchForCoordinatesOptions?,
                completionHandler: @escaping Geo.ResultsHandler<[Geo.Place]>) {}
    
    @available(*, unavailable, renamed: "query(byIdentifier:)")
    func availableMaps(completionHandler: @escaping Geo.ResultsHandler<[Geo.MapStyle]>) {}
    
    @available(*, unavailable, renamed: "query(byIdentifier:)")
    func defaultMap(completionHandler: @escaping Geo.ResultsHandler<Geo.MapStyle>) {}
}

struct Consumer {
    let geo = Geo()
    
    func search() async {
//        geo.search(for: "blah", options: nil) { result in
//            dump(result)
//        }
    }
}
