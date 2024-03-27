//
//  File.swift
//  
//
//  Created by Ronald Mannak on 3/26/24.
//
// Source: https://www.swiftbysundell.com/tips/default-decoding-values/

import Foundation

protocol DecodableDefaultSource {
    associatedtype Value: Decodable
    static var defaultValue: Value { get }
}

/// Property wrapper to enable default values for Codable
/// # See also
/// [Default decoding values](https://www.swiftbysundell.com/tips/default-decoding-values/)
enum DecodableDefault {}

extension DecodableDefault {
    @propertyWrapper
    struct Wrapper<Source: DecodableDefaultSource> {
        typealias Value = Source.Value
        var wrappedValue = Source.defaultValue
        
        init(wrappedValue: Source.Value = Source.defaultValue) {
            self.wrappedValue = wrappedValue
        }
    }
}

extension DecodableDefault.Wrapper: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        wrappedValue = try container.decode(Value.self)
    }
}

extension KeyedDecodingContainer {
    func decode<T>(_ type: DecodableDefault.Wrapper<T>.Type,
                   forKey key: Key) throws -> DecodableDefault.Wrapper<T> {
        try decodeIfPresent(type, forKey: key) ?? .init()
    }
}

extension DecodableDefault {
    typealias Source = DecodableDefaultSource
    typealias List = Decodable & ExpressibleByArrayLiteral
    typealias Map = Decodable & ExpressibleByDictionaryLiteral

    enum Sources {
        enum True: Source {
            static var defaultValue: Bool { true }
        }

        enum False: Source {
            static var defaultValue: Bool { false }
        }

        enum EmptyString: Source {
            static var defaultValue: String { "" }
        }

        enum EmptyList<T: List>: Source {
            static var defaultValue: T { [] }
        }

        enum EmptyMap<T: Map>: Source {
            static var defaultValue: T { [:] }
        }
        
        // TODO: Can we have a single solution for both Int and Float like so:
        /*
        enum One: Source {
            static var defaultValue: any Numeric { 1 }
        }
        
        enum Zero: Source {
            static var defaultValue: any Numeric { 0 }
        }
        */
        
        enum One: Source {
            static var defaultValue: Int { 1 }
        }
        
        enum Zero: Source {
            static var defaultValue: Int { 0 }
        }
        
        enum OneFloat: Source {
            static var defaultValue: Float { 1 }
        }
        
        enum ZeroFloat: Source {
            static var defaultValue: Float { 0 }
        }
    }
}

extension DecodableDefault.Wrapper: Equatable where Value: Equatable {}
extension DecodableDefault.Wrapper: Hashable where Value: Hashable {}

extension DecodableDefault.Wrapper: Encodable where Value: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}

extension DecodableDefault {
    typealias True = Wrapper<Sources.True>
    typealias False = Wrapper<Sources.False>
    typealias EmptyString = Wrapper<Sources.EmptyString>
    typealias EmptyList<T: List> = Wrapper<Sources.EmptyList<T>>
    typealias EmptyMap<T: Map> = Wrapper<Sources.EmptyMap<T>>
    typealias One = Wrapper<Sources.One>
    typealias Zero = Wrapper<Sources.Zero>
    typealias OneFloat = Wrapper<Sources.OneFloat>
    typealias ZeroFloat = Wrapper<Sources.ZeroFloat>
}
