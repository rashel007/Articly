//
//  ArticlesListService.swift
//  NyBestArticles
//
//  Created by sadman samee on 11/14/19.
//  Copyright © 2019 Sadman Samee. All rights reserved.
//

import Moya

public enum ArticlesListService {
    case mostViewedArticles(days: Int)
}

extension ArticlesListService: TargetType {
    public var baseURL: URL {
        return URL(string: Constant.Url.base)!
    }

    public var path: String {
        switch self {
        case let .mostViewedArticles(days):
            return "/svc/mostpopular/v2/viewed/\(days).json"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .mostViewedArticles:
            return .get
        }
    }

    public var task: Task {
        switch self {
        case .mostViewedArticles:
            return .requestParameters(parameters: ["api-key": Constant.ApiKey.nyApiKey], encoding: URLEncoding.queryString)
        }
    }

    public var headers: [String: String]? {
        return ["Content-Type": "application/json; charset=utf-8"]
    }

    public var authorizationType: AuthorizationType {
        return .none
    }

    public var validationType: ValidationType {
        return .successCodes
    }

    public var sampleData: Data {
        switch self {
        case .mostViewedArticles:

            guard let path = Bundle.main.path(forResource: MockJson.articleList.rawValue, ofType: "json"),
                let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else {
                return "".data(using: String.Encoding.utf8)!
            }
            return data
        }
    }
}
