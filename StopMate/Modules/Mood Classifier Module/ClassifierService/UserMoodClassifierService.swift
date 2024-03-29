//
//  UserMoodClassifierService.swift
//  QuitMate
//
//  Created by Саша Василенко on 16.04.2023.
//

import Vision
import CoreML
import UIKit
import Combine

enum ClassificationResults {
    case succes, failure
}

protocol UserMoodClassifierServiceProtocol: AnyObject {
    var classificationPublisher: PassthroughSubject<String, Never> { get set}
    func classifyImage(image: Data)
    func checkIfFacePresent(image: Data, completion: @escaping(ClassificationResults) -> Void)
    func cropImage(image: Data) -> UIImage?
}

final class UserMoodClassifierService: UserMoodClassifierServiceProtocol {
    var classificationPublisher = PassthroughSubject<String, Never>()
//    private lazy var classificationRequest: VNCoreMLRequest = {
//        do {
//            let model = try VNCoreMLModel(for: CNNEmotions().model)
//            let request = VNCoreMLRequest(model: model) { request, _ in
//                if let classifications = request.results as? [VNClassificationObservation] {
//                    print("Classification results: \(classifications)")
//                    let topClassification = classifications.first.map {
//                        (confidence: $0.confidence, identifier: $0.identifier)
//                    }
//                    print("Top classifications: \(topClassification)")
//                    if let topClassification {
//                        self.classificationPublisher.send(topClassification.identifier)
//                    }
//                }
//            }
//            request.imageCropAndScaleOption = .centerCrop
//            return request
//        } catch {
//            fatalError("Classification Error")
//        }
//    }()
    
    func classifyImage(image: Data) {
        guard let imageFromData = UIImage(data: image) else { return }
        guard let orientation = CGImagePropertyOrientation(
            rawValue: UInt32(imageFromData.imageOrientation.rawValue)) else {
            return
        }
        let croppedImage = cropImage(image: image)
        guard let ciImage = CIImage(image: croppedImage!) else {
            fatalError("Unable to create \(CIImage.self) from \(image).")
        }
//        DispatchQueue.global(qos: .userInitiated).async {
//            let handler =
//            VNImageRequestHandler(ciImage: ciImage, orientation: orientation)
//            do {
//                let classificationRequest = self.classificationRequest
//                try handler.perform([classificationRequest])
//            } catch {
//                print("Failed to perform classification.\n\(error.localizedDescription)")
//            }
//        }
    }
    
    func checkIfFacePresent(image: Data, completion: @escaping(ClassificationResults) -> Void) {
        let image = UIImage(data: image)!
        let imageCG = image.cgImage!
        let request = VNDetectFaceRectanglesRequest { (req, err) in
            if err != nil {
                completion(.failure)
                return
            }
            req.results?.forEach({ (res) in
                guard let faceObservation = res as? VNFaceObservation else {return}
                completion(.succes)
            })
        }
#if targetEnvironment(simulator)
        request.usesCPUOnly = true
#endif
        let handler = VNImageRequestHandler(cgImage: imageCG, options: [:])
        do {
            try handler.perform([request])
        } catch let reqErr {
            print("Error", reqErr)
        }
    }
    
    func cropImage(image: Data) -> UIImage? {
        let image = UIImage(data: image)
        guard let imageUnwrapped = image else { return nil }
        let cgImage = imageUnwrapped.cgImage
        guard let cgImageUnwrapped = cgImage else { return nil }
        // Resize the cropped image to 224x224 pixels
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 224, height: 224))
        let resizedImage = renderer.image { context in
            UIImage(cgImage: cgImageUnwrapped).draw(in: CGRect(origin: .zero, size: CGSize(width: 224, height: 224)))
        }
        
        return resizedImage
    }

    
}
