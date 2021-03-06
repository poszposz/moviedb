//
//  NetworkError.swift
//  MovieDB
//

import Foundation

/// Represents all errors that can be thrown while performin network requests.
///
/// - systemError: operating system threw an error. This is porbably caused by no internet connection, wrong SSL cerficiate installed etc.
/// - describedError: request returned 4XX return code with a desription of an error.
/// - improperResponse: parsing the obtained response was impossible. Check the Codable conformances in models.
/// - notFound: received a 404 error code in response.
/// - badRequest: received a 40X indicating the performed request contained wrong data.
/// - serverError: received a 5XX error. Probably the server is down.
/// - unauthorized: received a 401 error. Did not provide sufficien authorization.
internal enum NetworkError: Error {

    case systemError(error: Error)
    case describedError(description: String)
    case improperResponse(error: Error)
    case notFound
    case badRequest
    case serverError
    case unauthorized

    /// Initializes a new instance of APIRequestError. Created only if passed code indicated error.
    ///
    /// - Parameter code: HTTP status code.
    init?(code: Int) {
        switch code {
        case 404:
            self = .notFound
        case 401:
            self = .unauthorized
        case 400...499:
            self = .badRequest
        case 500...599:
            self = .serverError
        default:
            return nil
        }
    }

    /// Resturns a human readable description of the error.
    internal var humanReadableDescription: String {
        switch self {
        case .systemError(error: let error):
            return error.localizedDescription
        case .describedError(description: let description):
            return description
        case .notFound:
            return "There seems to be some issues with the API link. Please contact us."
        case .badRequest, .improperResponse(error: _):
            return "There seems to be some issues with the API response. Please contact us."
        case .unauthorized:
            return "Authorization token expired. Please contact us."
        case .serverError:
            return "Server is not responding for some reason. Please try again later."
        }
    }
}
