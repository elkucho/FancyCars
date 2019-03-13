//
//  DetailsViewController.swift
//  fancycars
//
//  Created by Marco Lima on 2019-03-11.
//  Copyright © 2019 LIM4. All rights reserved.
//

import UIKit


protocol DetailsViewControllerDelegate: class {
    func removeBlurredBackgroundView()
}

class DetailsViewController: UIViewController {

    @IBOutlet weak var detailsImage: UIImageView!    
    @IBOutlet weak var detailsName: UILabel!
    @IBOutlet weak var detailsMAke: UILabel!
    @IBOutlet weak var detailsModel: UILabel!
    @IBOutlet weak var detailsYear: UILabel!
    @IBOutlet weak var buttonBuy: UIButton!
    
    weak var delegate: DetailsViewControllerDelegate?
    
    var selectedVehicle = FancyCarsDTO.init(id: 0, img: "", name: "", make: "", model: "", year: 0, availability: "")
    
    @IBAction func buttonClose(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
        delegate?.removeBlurredBackgroundView()
    }
    
    
    @IBAction func buttonBuyAction(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "Congratulations!", message: "Nice purchase! Enjoy your fancy car!", preferredStyle: .alert)
        
        let actionOk = UIAlertAction(title: "Ok", style: .default, handler: { action in
            self.dismiss(animated: true, completion: nil)
            self.delegate?.removeBlurredBackgroundView()
        })
        
        alertController.addAction(actionOk)
        present(alertController, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        detailsImage.image = UIImage(named: selectedVehicle.img)
        detailsName.text = selectedVehicle.name
        detailsMAke.text = selectedVehicle.make
        detailsModel.text = selectedVehicle.model
        detailsYear.text = String(selectedVehicle.year)
        
        if selectedVehicle.availability == "In Dealership" {
            buttonBuy.isEnabled = true
            buttonBuy.setTitle("Buy", for: .normal)
        } else {
            buttonBuy.isEnabled = false
            buttonBuy.setTitle(selectedVehicle.availability, for: .disabled)
        }
        

    }

    override func viewDidLayoutSubviews() {
        view.backgroundColor = UIColor.clear
    }


}
