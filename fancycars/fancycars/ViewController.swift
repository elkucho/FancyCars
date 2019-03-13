//
//  ViewController.swift
//  fancycars
//
//  Created by Marco Lima on 2019-03-11.
//  Copyright © 2019 LIM4. All rights reserved.
//

import UIKit


struct Years {
    var year = ""
}

class ViewController: UIViewController, DetailsViewControllerDelegate {

    var allFancyCars : [FancyCarsDTO] = []
    var allFancyCarsFiltered : [FancyCarsDTO] = []
    var distinctYears : [String] = []
    let dataModel = FancyCarsModel()
    var fetchingMore = false
    var isFiltering = false
    
    @IBAction func button(_ sender: UIButton) {
        
        // This is not the best way to do it but I didn't want to use 3rd party controls that I didn't know
        // Although I am using a 3rd party solution, it's simple code so I could "simulate" the dropdown
        // Also, the use of strings... I don't like it but have more important fetaures to work on :)
        
        let controller = ArrayChoiceTableViewController(distinctYears) { (selectedYear) in
            
            self.yearsFilter.year = selectedYear
            
            switch selectedYear {
            case "Clear Filter":
                
                self.labelCurrentFilter.text = "Showing All Fancy Cars"
                self.allFancyCarsFiltered = self.dataModel.originalFancyCars
                self.allFancyCars = self.dataModel.originalFancyCars
                self.isFiltering = false
                self.fancyCarsTable.reloadData()
                print("Cleared filter")
                
            case "Load Original Cars":
                
                self.loadFancyCars()
                
            default :
                
                self.labelCurrentFilter.text = "Showing Fancy Cards for \(selectedYear)"
                self.allFancyCarsFiltered = self.allFancyCars.filter { String($0.year) == selectedYear }
                self.isFiltering = true
                self.fancyCarsTable.reloadData()
                print("Fitlered return \(self.allFancyCarsFiltered.count) Fancy Cars for the year \(selectedYear)")

            }
            
        }
        controller.preferredContentSize = CGSize(width: 300, height: 200)
        showPopup(controller, sourceView: sender)
        
    }
    
    var yearsFilter = Years() {
        didSet {
            self.view.setNeedsLayout()
        }
    }
    
    @IBOutlet weak var fancyCarsTable: UITableView!
    @IBOutlet weak var labelCurrentFilter: UILabel!
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Loading all values from JSON
        loadFancyCars()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerConfigCell()
    }
    
    
    func registerConfigCell() {
        
        fancyCarsTable.register(UINib(nibName: "FancyCarCell", bundle: nil), forCellReuseIdentifier: "fancycarscell")
        fancyCarsTable.register(UINib(nibName: "LoadingCell", bundle: nil), forCellReuseIdentifier: "loadingcell")
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let indexPath = fancyCarsTable.indexPathForSelectedRow else { return }
        let singleCar = allFancyCarsFiltered[indexPath.row]
        
        
        if let identifier = segue.identifier {
            if identifier == "showmodal" {
                if let viewController = segue.destination as? DetailsViewController {
                    viewController.selectedVehicle = singleCar
                    viewController.delegate = self
                    viewController.modalPresentationStyle = .overFullScreen
                }
            }
        }
    }
    
    //MARK: - Load Cars -
    
    func loadFancyCars() {
        
        dataModel.loadCars { (success, resultData) in
            
            if success {
                
                
                self.allFancyCarsFiltered = resultData
                self.allFancyCars = self.allFancyCarsFiltered
                let allYears = self.allFancyCarsFiltered.distinct{ $0.year }
                self.distinctYears = allYears.compactMap { String($0.year) } // return array of date
                self.distinctYears.append(contentsOf: ["Clear Filter","Load Original Cars"])
                self.labelCurrentFilter.text = "Showing All Fancy Cars"
                
                self.fancyCarsTable.reloadData()
                
            } else {
                // Just "break" the JSON file to similute this
                // It could have a UIAlert with try again/cancel options
                self.labelCurrentFilter.text = "Sorry! Technical Issues!"
                
            }
        }

    }
    
    
    //MARK: - Visual Effects
    
    func overlayBlurredBackgroundView() {
        
        let blurredBackgroundView = UIVisualEffectView()
        
        blurredBackgroundView.frame = view.frame
        blurredBackgroundView.effect = UIBlurEffect(style: .dark)
        blurredBackgroundView.alpha = 0.9
        
        view.addSubview(blurredBackgroundView)
        
    }
    
    func removeBlurredBackgroundView() {
        
        for subview in view.subviews {
            if subview.isKind(of: UIVisualEffectView.self) {
                subview.removeFromSuperview()
            }
        }
    }
    
    private func showPopup(_ controller: UIViewController, sourceView: UIView) {
        
        let presentationController = AlwaysPresentAsPopover.configurePresentation(forController: controller)
        presentationController.sourceView = sourceView
        presentationController.sourceRect = sourceView.bounds
        presentationController.permittedArrowDirections = [.down, .up]
        present(controller, animated: true)
        
    }

}


extension ViewController : UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return allFancyCarsFiltered.count
        } else if section == 1 && fetchingMore {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            
            guard let carsCell = fancyCarsTable.dequeueReusableCell(withIdentifier: "fancycarscell") as? FancyCarCell else {
                return UITableViewCell()
            }
            
            let singleCar = allFancyCarsFiltered[indexPath.row]
            
            carsCell.fancyName.text = singleCar.name.uppercased()
            carsCell.fancyMake.text = singleCar.make
            carsCell.fancyModel.text = singleCar.model
            carsCell.fancyImage.image = UIImage(named: singleCar.img)
            
            return carsCell

        } else {
            
            guard let loadingCell = fancyCarsTable.dequeueReusableCell(withIdentifier: "loadingcell") as? LoadingCell else {
                return UITableViewCell()
            }
            
            loadingCell.loadingSpinner.stopAnimating()
            return loadingCell

        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        definesPresentationContext = true
        providesPresentationContextTransitionStyle = true
        overlayBlurredBackgroundView()
        performSegue(withIdentifier: "showmodal", sender: nil)
        
    }
    
    
    
}


/*
 
 Honestly, inifinite scrolling, is the first time I had to use.
 I did find a solution online that I could leverage but I need to admit that
 this is not at all the best solution. Specially because I'm not actually using
 service calls to populate the data. I'm just appending the current data into
 itself so I could simulate the infinite scrolling.
 
 I would need more time and understand how to implement this more efficietly using proper
 service calls.
 
 */


extension ViewController : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offSetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offSetY > contentHeight - scrollView.frame.height {
            if !fetchingMore {
                getMoreCars()
            }
        }

        
    }
    
    func getMoreCars() {
        
        fetchingMore = true
        print("Get More Data")
        
        
        labelCurrentFilter.text = "Reloading Fancy Cars!"
        fancyCarsTable.reloadSections(IndexSet(integer: 1), with: .none)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            
            self.fetchingMore = false
            
            self.dataModel.duplicateFancyCars()
            self.allFancyCarsFiltered = self.dataModel.originalFancyCars
            self.allFancyCars = self.dataModel.originalFancyCars

            print("We Have More Data : \(self.dataModel.originalFancyCars.count) cars")
           
            self.fancyCarsTable.reloadData()
            self.labelCurrentFilter.text = "Showing All Fancy Cars"
            
        })
        
    }
    
}
