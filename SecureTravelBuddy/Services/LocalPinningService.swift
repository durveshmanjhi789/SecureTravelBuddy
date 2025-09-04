//
//  LocalPinningService.swift
//  SecureTravelBuddy
//
//  Created by Durvesh Manjhi on 03/09/25.
//

import Alamofire
import Foundation

class LocalPinningService {
    
    static let shared = LocalPinningService()
    private let session:Session
    
    private init(){
        let certUrl = Bundle.main.url(forResource: "server", withExtension: "cer")!
        let certificate = SecCertificateCreateWithData(nil, try! Data(contentsOf: certUrl) as CFData)!
        let evaluator = PinnedCertificatesTrustEvaluator(certificates: [certificate])
        let serverTrustManager = ServerTrustManager(evaluators: ["localhost":evaluator])
        session = Session(serverTrustManager: serverTrustManager)
        
    }
    
    func fetchData() async throws -> Data{
        try await withCheckedThrowingContinuation { continuation in
            session.request("https://localhost:3000/test") //demo url
                .validate()
                .responseData { response in
                    switch response.result{
                    case .success(let data):
                        continuation.resume(returning: data)
                        
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
        
    }
}
