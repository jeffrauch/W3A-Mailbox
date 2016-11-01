//
//  MailboxViewController.swift
//  W3A-Mailbox
//
//  Created by Jeff Rauch on 10/23/16.
//  Copyright © 2016 Jeff Rauch. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {

    // outlets
    @IBOutlet weak var mailboxScrollView: UIScrollView!
    @IBOutlet weak var messageView: UIImageView!
    @IBOutlet weak var messageContainer: UIView!
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var masterView: UIView!
    @IBOutlet weak var menuView: UIImageView!
    
    // full screens
    @IBOutlet weak var laterFullScreen: UIImageView!
    @IBOutlet weak var listFullScreen: UIImageView!
    
    // icons
    @IBOutlet weak var laterIcon: UIImageView!
    @IBOutlet weak var archiveIcon: UIImageView!
    @IBOutlet weak var deleteIcon: UIImageView!
    @IBOutlet weak var listIcon: UIImageView!
    
    // original position
    var messageViewOriginalX: CGFloat!
    var archiveIconOriginalX: CGFloat!
    var laterIconOriginalX: CGFloat!
    var deleteIconOriginalX: CGFloat!
    var listIconOriginalX: CGFloat!
    var feedImageOriginalY: CGFloat!
    var masterViewOriginalX: CGFloat!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set opacity to zero
        archiveIcon.alpha = 0
        laterIcon.alpha = 0
        deleteIcon.alpha = 0
        listIcon.alpha = 0
        
        // set position
        archiveIconOriginalX = archiveIcon.frame.origin.x
        laterIconOriginalX = laterIcon.frame.origin.x
        deleteIconOriginalX = deleteIcon.frame.origin.x
        listIconOriginalX = listIcon.frame.origin.x
        feedImageOriginalY = feedImageView.frame.origin.y
        messageViewOriginalX = messageView.frame.origin.x
        masterViewOriginalX = masterView.frame.origin.x
   
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func didPanMasterView(_ sender: UIPanGestureRecognizer) {
        
        menuView.alpha = 1
        let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)
        print("velocity", velocity)
        
        if sender.state == .began {
            
        } else if sender.state == .changed {
            self.masterView.frame.origin.x = self.masterViewOriginalX + translation.x
            
            
        } else if sender.state == .ended {
            if velocity.x > 0 {
                //                self.masterParentView.frame.origin.x = self.masterParentViewOriginalX + (translation.x + 350)
                
                
                UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseInOut, animations: {
                    self.masterView.frame.origin.x = self.masterViewOriginalX + 335
                    
                    }, completion: { (Bool) in
                        
                })
                
            } else if velocity.x < 0{
                UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseInOut, animations: {
                    self.masterView.frame.origin.x = self.masterViewOriginalX
                    
                    }, completion: { (Bool) in
                        
                })
            }
            
            
        }
    }
    

    
    @IBAction func didPanMessage(_ sender: UIPanGestureRecognizer) {
        
        let location = sender.location(in: view)
        let velocity = sender.velocity(in: view)
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            
            // Initially hide the icons
            archiveIcon.alpha = 0
            deleteIcon.alpha = 0
            laterIcon.alpha = 0
            listIcon.alpha = 0
            
        } else if sender.state == .changed {
            
            messageView.frame.origin.x = messageViewOriginalX + translation.x
            
            if translation.x > 0 && translation.x < 60 {
                
                // grey/right
                
                messageContainer.backgroundColor = UIColor(red:0.29, green:0.29, blue:0.29, alpha:1.00)
                archiveIcon.alpha = 0.5
                
            } else if translation.x >= 60 && translation.x < 260 {
                
                // green/right
                
                messageContainer.backgroundColor = UIColor(red:0.25, green:0.76, blue:0.43, alpha:1.00)
                archiveIcon.alpha = 1
                archiveIcon.frame.origin.x = archiveIconOriginalX + (translation.x - 70)
                
            } else if translation.x > 260 && translation.x > 269 {
                
                // red/right
                
                messageContainer.backgroundColor = UIColor(red:1.00, green:0.23, blue:0.19, alpha:1.00)
                archiveIcon.alpha = 0
                deleteIcon.alpha = 1
                deleteIcon.frame.origin.x = archiveIconOriginalX + (translation.x - 70)
                
                
                
            } else if translation.x >= 270  {
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.listFullScreen.alpha = 1
                })
                
            } else if translation.x < 0 && translation.x > -60 {
                
                // grey/left
                
                messageContainer.backgroundColor = UIColor(red:0.29, green:0.29, blue:0.29, alpha:1.00)
                laterIcon.alpha = 0.5
                listIcon.alpha = 0
                
            } else if translation.x <= -60 && translation.x > -260 {
                
                // yellow/left
                messageContainer.backgroundColor = UIColor(red:0.97, green:0.91, blue:0.11, alpha:1.00)
                laterIcon.alpha = 1
                listIcon.alpha = 0
                laterIcon.frame.origin.x = laterIconOriginalX + (translation.x + 70)

            } else if translation.x < -260 && translation.x > -269 {
                
                // brown/left
                messageContainer.backgroundColor = UIColor(red:0.55, green:0.34, blue:0.16, alpha:1.00)
                laterIcon.alpha = 0
                listIcon.alpha = 1
                listIcon.frame.origin.x = listIconOriginalX + (translation.x + 70)
                
                
            } else if translation.x <= -270 {
                
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.laterFullScreen.alpha = 1
                })
            }

            
            
        } else if sender.state == .ended {
            
            if velocity.y > 0 {
                UIView.animate(withDuration:0.2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options:[] ,
                               animations: { () -> Void in
                                self.messageView.frame.origin.x = self.messageViewOriginalX
                    }, completion: nil)
            } else {
                UIView.animate(withDuration:0.2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options:[] ,
                               animations: { () -> Void in
                                self.messageView.frame.origin.x = self.messageViewOriginalX
                    }, completion: nil)
            }
                
        }
                    print("\(translation)")
 
    }
    

    @IBAction func didTapLater(_ sender: UITapGestureRecognizer) {
        
        laterFullScreen.alpha = 0
        UIView.animate(withDuration: 0.1, animations: {
            self.messageView.frame.origin.x = self.messageViewOriginalX - 300
            self.archiveIcon.alpha = 0
            
        }) { (Bool) in
            UIView.animate(withDuration: 0.1, animations: {
                self.messageView.alpha = 1
            }) {(Bool) in
                UIView.animate(withDuration: 0.2, animations: {
                    self.feedImageView.frame.origin.y = self.feedImageOriginalY - 86
                    self.messageContainer.alpha = 0
                })
            }}
    }

    @IBAction func didTapList(_ sender: UITapGestureRecognizer) {
        listFullScreen.alpha = 0
        UIView.animate(withDuration: 0.1, animations: {
            self.messageView.frame.origin.x = self.messageViewOriginalX + 300
            self.listIcon.alpha = 0
            
        }) { (Bool) in
            UIView.animate(withDuration: 0.1, animations: {
                self.messageView.alpha = 1
            }) {(Bool) in
                UIView.animate(withDuration: 0.2, animations: {
                    self.feedImageView.frame.origin.y = self.feedImageOriginalY - 86
                    self.messageContainer.alpha = 0
                })
            }}
    }

}
