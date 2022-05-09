//
//  ViewController.swift
//  StickerDemo
//
//  Created by P21-0012 on 09/05/22.
//

import UIKit
import PencilKit
import IRSticker_swift

class SavedSticker {
    var frame: CGRect = .zero
    var center: CGPoint = .zero
    var transform: CGAffineTransform = .identity
    var image: UIImage = UIImage()
    var tag: Int = 0
}

class ViewController: UIViewController, IRStickerViewDelegate, PKCanvasViewDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
        
        let canvasView = PKCanvasView()
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        canvasView.tool = PKInkingTool(.marker, color: .black, width: 40)
        canvasView.allowsFingerDrawing = true
        canvasView.delegate = self
        view.addSubview(canvasView)
        
        let btnAdd = UIButton()
        btnAdd.translatesAutoresizingMaskIntoConstraints = false
        btnAdd.setTitle("Add", for: .normal)
        btnAdd.backgroundColor = .systemBlue
        btnAdd.addTarget(self, action: #selector(btnAddTapped(sender:)), for: .touchUpInside)
        view.addSubview(btnAdd)
        
        NSLayoutConstraint.activate([
            canvasView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            canvasView.topAnchor.constraint(equalTo: view.topAnchor),
            canvasView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            canvasView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            btnAdd.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            btnAdd.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            btnAdd.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            
            if self == nil{
                return
            }
            
            for object in SavedData.shared.arrSavedSticker{
                let sticker = IRStickerView(frame: object.frame, contentImage: object.image)
                sticker.enabledControl = true
                sticker.enabledBorder = true
                sticker.delegate = self
                sticker.contentView.transform = object.transform
                sticker.center = object.center
                sticker.tag = object.tag
                sticker.relocalControlView()
                self!.view.addSubview(sticker)
            }
        }
    }
    
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
    }
    
    func canvasViewDidFinishRendering(_ canvasView: PKCanvasView) {
    }
    
    func canvasViewDidBeginUsingTool(_ canvasView: PKCanvasView) {
    }
    
    @IBAction func btnclose(_ sender: Any) {
        
        for object in SavedData.shared.arrSavedSticker {
            if let sticker = view.viewWithTag(object.tag) as? IRStickerView{
                object.transform = sticker.contentView.transform
                object.center = sticker.center
            }
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAddTapped(sender: UIButton){
        let sticker1 = IRStickerView(frame: CGRect.init(x: 0, y: 0, width: 150, height: 150), contentImage: UIImage.init(named: "sticker1.png")!)
        sticker1.center = view.center
        sticker1.enabledControl = true
        sticker1.enabledBorder = true
        sticker1.delegate = self
        sticker1.tag = Int.random(in: 0...999999)
        view.addSubview(sticker1)
        
        let object = SavedSticker()
        object.tag = sticker1.tag
        object.frame = sticker1.frame
        object.center = sticker1.center
        object.transform = sticker1.contentView.transform
        object.image = sticker1.contentImage!
        SavedData.shared.arrSavedSticker.append(object)
    }
    
    func stickerView(stickerView: IRStickerView, imageForLeftTopControl recommendedSize: CGSize) -> UIImage? {
        return UIImage(named: "close")
    }
    
    func stickerView(stickerView: IRStickerView, imageForRightBottomControl recommendedSize: CGSize) -> UIImage? {
        return UIImage(named: "resize")
    }
    
    func stickerView(stickerView: IRStickerView, imageForLeftBottomControl recommendedSize: CGSize) -> UIImage? {
        return nil
    }
    
    func stickerView(stickerView: IRStickerView, imageForRightTopControl recommendedSize: CGSize) -> UIImage? {
        return nil
    }
}

