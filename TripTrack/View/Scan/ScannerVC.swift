//
//  ScannerVC.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-06-25.
//

import UIKit
import SwiftUI
import AVFoundation

class ScannerVC: UIViewController {
    
//    var countNumbers: Int = 0
    //    var veh_make = UserDefaults.standard.string(forKey: "veh_make") ?? "H"
    
    var captureSession = AVCaptureSession()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var barCodeFrameView: UIView?
    
    var vinCode = ""
    
    let mainView: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupElements()
        openScanner()
    }
    
//     MARK: - Setup Elements
    
    func setupElements() {
        
        self.view.addSubview(mainView)
        mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
//    MARK: - Action Buttons
    
    public func editButtonTapped() {
        
        let ac = UIAlertController(title: "Enter VIN manually", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned ac] _ in
            let answer = ac.textFields![0].text
            self.vinCode = answer!.uppercased()
            // do something interesting with "answer" here
            let alert = UIAlertController(title: "Is it correct?", message: "vin code is:\n \(self.vinCode)", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { acion in
                
                UserDefaults.standard.set(self.vinCode, forKey: "vinCode")
        
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { action in
                
                self.captureSession.startRunning()
            }))
            
            self.present(alert, animated: true)
        }
        
        ac.addAction(submitAction)
        
        present(ac, animated: true)
    }
    
    func openScanner() {
        
        // Get the back-facing camera for capturing videos
        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            
            print("Failed to get the camera device")
            return
        }
        
        do {
            
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            // Set the input device on the capture session.
            captureSession.addInput(input)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417, .qr, .code39, .code39Mod43, .dataMatrix]
            
            // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            mainView.layer.addSublayer(videoPreviewLayer!)
            
            // Move the message label and top bar to the front
//            mainView.bringSubviewToFront(topNavPanel)
//            mainView.bringSubviewToFront(bottomNavPanel)
            
            // Start video capture.
            DispatchQueue.global(qos: .background).async {
                self.captureSession.startRunning()
            }
            
            // Initialize QR Code Frame to highlight the QR code
            barCodeFrameView = UIView()
            
            if let barCodeFrameView = barCodeFrameView {
                
                barCodeFrameView.layer.borderColor = UIColor.green.cgColor
                barCodeFrameView.layer.borderWidth = 2
                mainView.addSubview(barCodeFrameView)
                mainView.bringSubviewToFront(barCodeFrameView)
            }
            
        } catch {
            
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ScannerVC: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects.count == 0 {
            
            barCodeFrameView?.frame = CGRect.zero
//            messageLabel.text = "No VIN code is detected"
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if (metadataObj.type == AVMetadataObject.ObjectType.code39) ||
            (metadataObj.type == AVMetadataObject.ObjectType.qr) ||
            (metadataObj.type == .ean8) ||
            (metadataObj.type == .ean13) ||
            (metadataObj.type == .pdf417) ||
            (metadataObj.type == .code39Mod43) ||
            (metadataObj.type == .dataMatrix) {
            
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            barCodeFrameView?.frame = barCodeObject!.bounds
            
            if metadataObj.stringValue != nil {
                
                self.vinCode = metadataObj.stringValue ?? "VIN not found"
//                self.vinCode = messageLabel.text ?? "VIN not found"
                
                if self.vinCode.contains(",") {
                    
                    let endChar = vinCode.range(of: ",")!.lowerBound
                    //                    vinCode = vinCode.substring(to: endChar)
                    vinCode = String(vinCode[..<endChar])
                }
                
                UserDefaults.standard.set(self.vinCode.suffix(17), forKey: "vinCode")
                
                let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                impactHeavy.impactOccurred()
                
                self.captureSession.stopRunning()
                
                alertSheet(vincode: vinCode)
            }
        }
    }
    
    func alertSheet(vincode: String) {
        
        let alert = UIAlertController(title: "Is it correct?", message: "vin code is:\n \(vincode.suffix(17))", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { acion in
            
            let scanResultView = ScanResultView()
            let hostingController = UIHostingController(rootView: scanResultView)
            hostingController.modalPresentationStyle = .fullScreen
            self.present(hostingController, animated: true)
            
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { action in
            
            DispatchQueue.global(qos: .background).async {
                self.captureSession.startRunning()
            }
            
        }))
        
        self.present(alert, animated: true)
    }
}
