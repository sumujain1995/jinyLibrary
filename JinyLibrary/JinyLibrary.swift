//
//  JinyLibrary.swift
//  JinyLibrary
//
//  Created by Sumeet  Jain on 01/11/20.
//  Copyright © 2020 Sumeet Jain. All rights reserved.
//

import UIKit
import AVKit

public class JinyLibrary {

    private var floatingBtnVC: FloatingButtonViewController?
    private var audioPlayer: AVAudioPlayer?
    private let fingerImgVw : UIImageView = {
        let imgVw = UIImageView(image: UIImage(named: "finger"))
        imgVw.contentMode = .scaleAspectFit
        return imgVw
    }()
    private var soundUrl: URL?
    private var playAudio = false
    private var infiniteTimer: Timer?


    
    public init() {
        if floatingBtnVC  == nil {
            addFAB()
            
            //Pre-Loading the Audio resources
            soundUrl = Bundle.main.url(forResource: "audio", withExtension: "mp3")
            loadSong()
        }
    }
    
    //MARK:- API FOR ADDING THE FINGER ON THE GIVEN VIEW
    public func getHighlight(_ onView: UIView){
        //Removing the previous finger and Stopping the timer
        infiniteTimer?.invalidate()
        fingerImgVw.removeFromSuperview()

        fingerImgVw.frame.origin = calculatePosition(contentView: onView)
        onView.superview?.addSubview(fingerImgVw)
        playAudio = true
        infiniteTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(animateImageView), userInfo: nil, repeats: true)
    }
    
    
    //MARK:- ADD FAB BUTTON
    private func addFAB() {
        floatingBtnVC = FloatingButtonViewController()
    }

    private func loadSong(){
        guard let url = soundUrl else {
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            
        } catch {
            print("Error playing audio")
        }
    }

    //MARK:-LOGIC FOR RESIZING and POSITIONING THE FINGER TIP

    //As the given image when resized to 200x200 then tip lies at 80,20
    private func calculatePosition( contentView: UIView) -> CGPoint {

        var xPos = contentView.center.x - 80
        var yPos = contentView.center.y - 20
        var size: CGFloat = 200
        
        var refrenceWidth = screenWidth
        var referenceHeight = screenHeight
        
        if let superview = contentView.superview {
            
            if let superScorllView = superview as? UIScrollView {
                
                if(referenceHeight < superScorllView.contentOffset.y){
                    referenceHeight = superview.frame.maxY
                }
                
                if (refrenceWidth < superScorllView.contentOffset.x) {
                    refrenceWidth = superview.frame.maxX
                }
                
            }
            else {
                if(referenceHeight < superview.frame.maxY){
                    referenceHeight = superview.frame.maxY
                }
                
                if (refrenceWidth < superview.frame.maxX) {
                    refrenceWidth = superview.frame.maxX
                }
            }
        }


        //Since they have 2:5 ratio i.e if the x-value is decrease by 2 then width needs to be decrease by 5
        // and Vertical ratio is 1:10 i.e if we decrease width(height) by 10 then we have to decrease yPos by 1

        //Left side clipping of the image
        //Right side Clipping of the image
        //Bottom Clipping of the image -> this we can handle up to some extent
        while (xPos < 0 || xPos + size > refrenceWidth || yPos + size > referenceHeight) {
            xPos = xPos + 2
            size = size - 5
            yPos = yPos + 0.5
        }

        fingerImgVw.frame.size = CGSize(width: size, height: size)
        return CGPoint(x: xPos, y: yPos)
    }


    @objc private func animateImageView() {

        fingerImgVw.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)

        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {[weak self] in
            self?.fingerImgVw.transform = CGAffineTransform.identity
        }) { [weak self] (complete) in
            if (complete && self?.playAudio != nil && (self?.playAudio)!){
                self?.playAudio = false
                self?.audioPlayer?.play()
            }
        }
    }
    
}
