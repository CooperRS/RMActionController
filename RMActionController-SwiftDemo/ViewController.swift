//
//  MasterViewController.swift
//  RMActionController-SwiftDemo
//
//  Created by Roland Moers on 19.08.15.
//  Copyright (c) 2015 Roland Moers. All rights reserved.
//

import UIKit
import RMActionController
import MapKit

class ViewController: UITableViewController {
    
    //MARK: Properties
    @IBOutlet weak var blackSwitch: UISwitch!
    @IBOutlet weak var blurSwitch: UISwitch!
    @IBOutlet weak var motionSwitch: UISwitch!
    @IBOutlet weak var bouncingSwitch: UISwitch!
    
    // MARK: Actions
    func openCustomActionController() {
        var style = RMActionControllerStyle.white
        if self.blackSwitch.isOn {
            style = RMActionControllerStyle.black
        }
        
        let selectAction = RMAction<UIView>(title: "Select", style: RMActionStyle.done) { controller in
            print("Custom action controller finished successfully")
        }
        
        let cancelAction = RMAction<UIView>(title: "Cancel", style: RMActionStyle.cancel) { _ in
            print("custom action controller was canceled")
        }
        
        let actionController = CustomViewActionController(style: style)!
        actionController.title = "Test"
        actionController.message = "This is a test message.\nPlease choose a date and press 'Select' or 'Cancel'."
        
        actionController.addAction(selectAction!)
        actionController.addAction(cancelAction!)
        
        //You can enable or disable blur, bouncing and motion effects
        actionController.disableBouncingEffects = !self.bouncingSwitch.isOn
        actionController.disableMotionEffects = !self.motionSwitch.isOn
        actionController.disableBlurEffects = !self.blurSwitch.isOn
        
        //On the iPad we want to show the date selection view controller within a popover. Fortunately, we can use iOS 8 API for this! :)
        //(Of course only if we are running on iOS 8 or later)
        if actionController.responds(to: Selector(("popoverPresentationController:"))) && UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad {
            //First we set the modal presentation style to the popover style
            actionController.modalPresentationStyle = UIModalPresentationStyle.popover
            
            //Then we tell the popover presentation controller, where the popover should appear
            if let popoverPresentationController = actionController.popoverPresentationController {
                popoverPresentationController.sourceView = self.tableView
                popoverPresentationController.sourceRect = self.tableView.rectForRow(at: IndexPath(row: 0, section: 0))
            }
        }
        
        //Now just present the date selection controller using the standard iOS presentation method
        present(actionController, animated: true, completion: nil)
    }
    
    func openMapActionController() {
        var style = RMActionControllerStyle.white
        if self.blackSwitch.isOn {
            style = RMActionControllerStyle.black
        }
        
        let selectAction = RMAction<MKMapView>(title: "Select", style: RMActionStyle.done) { controller in
            print("Map action controller finished successfully")
        }
        
        let cancelAction = RMAction<MKMapView>(title: "Cancel", style: RMActionStyle.cancel) { _ in
            print("Map action controller was canceled")
        }
        
        let actionController = MapActionController(style: style)!
        actionController.title = "Test"
        actionController.message = "This is a map action controller.\nPlease choose a date and press 'Select' or 'Cancel'."
        
        actionController.addAction(selectAction!)
        actionController.addAction(cancelAction!)
        
        //You can enable or disable blur, bouncing and motion effects
        actionController.disableBouncingEffects = !self.bouncingSwitch.isOn
        actionController.disableMotionEffects = !self.motionSwitch.isOn
        actionController.disableBlurEffects = !self.blurSwitch.isOn
        
        //On the iPad we want to show the date selection view controller within a popover. Fortunately, we can use iOS 8 API for this! :)
        //(Of course only if we are running on iOS 8 or later)
        if actionController.responds(to: Selector(("popoverPresentationController:"))) && UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad {
            //First we set the modal presentation style to the popover style
            actionController.modalPresentationStyle = UIModalPresentationStyle.popover
            
            //Then we tell the popover presentation controller, where the popover should appear
            if let popoverPresentationController = actionController.popoverPresentationController {
                popoverPresentationController.sourceView = self.tableView
                popoverPresentationController.sourceRect = self.tableView.rectForRow(at: IndexPath(row: 0, section: 0))
            }
        }
        
        //Now just present the date selection controller using the standard iOS presentation method
        present(actionController, animated: true, completion: nil)
    }
    
    // MARK: UITableView Delegates
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath as NSIndexPath).section == 0 && (indexPath as NSIndexPath).row == 0 {
            openCustomActionController()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

