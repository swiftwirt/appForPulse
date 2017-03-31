//
//  PTARecipeCell.swift
//  AppForPulse
//
//  Created by Ivashin Dmitry on 3/28/17.
//  Copyright © 2017 Ivashin Dmitry. All rights reserved.
//

import UIKit

class PTARecipeCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!

    var recipe: RecipeEntity! {
        didSet {
            if let image = recipe.image, recipe.imageThumbnail != "" {
                imgView.image = UIImage(data: image as Data, scale: 1.0)
            } else {
                imgView.image = UIImage(named: "no_image_available_icon")
            }
            titleLabel.text = recipe.title
            detailsLabel.text = recipe.details
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        handleAppearance()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgView.image = nil
        titleLabel.text = nil
        detailsLabel.text = nil
    }
    
    private func handleAppearance()
    {
        imgView.layer.masksToBounds = true
        imgView.layer.cornerRadius = imgView.frame.width / 2
        
        imgView.layer.borderWidth = 1.0
        imgView.layer.borderColor = UIColor.lightGray.cgColor
    }
}
