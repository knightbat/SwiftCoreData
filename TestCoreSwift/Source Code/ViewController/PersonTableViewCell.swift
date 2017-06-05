//
//  PersonTableViewCell.swift
//  TestCoreSwift
//
//  Created by Bindu on 25/01/17.
//  Copyright © 2017 Xminds. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var ageLabel: UILabel!
    @IBOutlet var jobLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
        @IBOutlet var userImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    if ([NSStringFromClass([subview class]) isEqualToString:@"UITableViewCellDeleteConfirmationControl"]) {
//    UIView *deleteButtonView = (UIView *)[subview.subviews objectAtIndex:0];
//    CGRect f = deleteButtonView.frame;
//    f.origin.x = 250;
//    f.origin.y = 47;
//    f.size.width = 30;
//    f.size.height = 50;
//    
//    CGRect sf = self.frame;
//    sf.size.width = 100;
//    sf.size.height = 100;
//    
//    deleteButtonView.frame = f;
//    self.frame = sf;
//    }
//    
//    override func layoutSubviews() {
//        
//        super.layoutSubviews()
//        UIView.beginAnimations(nil, context: nil)
//        UIView.setAnimationBeginsFromCurrentState(true)
//        UIView.setAnimationDuration(0.0)
//        
//        for subview in self.subviews as [UIView] {
//            
//            print(NSStringFromClass(subview.classForCoder))
//            
//            if (NSStringFromClass(subview.classForCoder)=="UITableViewCellDeleteConfirmationControl"){
//                
//                let delbuttonView :UIView = subview.subviews[0]
//                
//                var f : CGRect = delbuttonView.frame
//                f.origin.x = 5
//                f.origin.y = 10
//                f.size.width = 75
//                f.size.height = 40
//                
//                var sf : CGRect = self.frame
//                sf.size.width = 100
//                sf.size.height = 100
//                
//                delbuttonView.frame = f
//                self.frame = sf
//            }
//        }
//    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
