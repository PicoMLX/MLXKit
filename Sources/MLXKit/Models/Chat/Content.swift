//
//  Content.swift
//
//
//  Created by Ronald Mannak on 3/26/24.
//

import Foundation

public enum Content: Codable, Equatable {
    case string(String)
    case multipart([MultipartContent])
}

public struct MultipartContent: Codable, Equatable {
      
    public struct ImageURL: Codable, Equatable {
        let url: String
        let detail: String?
    }
    
    public enum ContentType: String, Codable, Equatable {
        case text, imageUrl
    }
    
    public let type: ContentType
    
    public let text: String?
    
    public let imageUrl: ImageURL?
}
