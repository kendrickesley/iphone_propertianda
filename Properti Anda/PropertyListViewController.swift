//
//  PropertyListViewController.swift
//  Properti Anda
//
//  Created by Kendrick on 22/8/17.
//  Copyright © 2017 Kendrick. All rights reserved.
//

import UIKit
import Material
import SwiftSpinner

class PropertyListViewController: UIViewController {
    @IBOutlet weak var propertyTableView:UITableView!
    fileprivate var menuButton: IconButton!
    let properties:Properties = Properties()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        SwiftSpinner.setTitleFont(UIFont(name: "Helvetica Neue", size: 22.0))
        propertyTableView.delegate = self
        propertyTableView.dataSource = self
        prepareMenuButton()
        prepareNavigationItem()
        SwiftSpinner.show("Requesting properties...")
        properties.requestProperties(callback: {
            SwiftSpinner.hide()
            self.propertyTableView.reloadData()
            return ""
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func prepareMenuButton() {
        menuButton = IconButton(image: Icon.cm.menu)
        menuButton.tintColor? = Color.white
        menuButton.addTarget(self, action: #selector(handleMenuButton), for: .touchUpInside)
    }
    
    fileprivate func prepareNavigationItem() {
        navigationItem.title = "Properties"
        navigationItem.detail = "Extends your portfolio"
        navigationItem.titleLabel.textColor = Color.white
        navigationItem.detailLabel.textColor = Color.white
        
        navigationItem.leftViews = [menuButton]
        //        navigationItem.rightViews = [starButton, searchButton]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        print(segue.identifier ?? "Default Segue")
        if segue.identifier == "propertySegue" {
            let indexPath = self.propertyTableView.indexPathForSelectedRow
            let property = self.properties.getProperty(byIndex: (indexPath?.row)!)
            print(property.getAddress())
            let propertyDetailView:PropertyDetailViewController = (segue.destination as! PropertyDetailViewController)
            propertyDetailView.property = property
        }
    }
    
}

extension PropertyListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
        self.performSegue(withIdentifier: "propertySegue", sender: self);
        for cell:PropertyCell in tableView.visibleCells as! [PropertyCell] {
            cell.bar?.backgroundColor = Color.white
        }
        let cell:PropertyCell = tableView.cellForRow(at: indexPath) as! PropertyCell
        cell.bar?.backgroundColor = Color.green.lighten4
//        let selectedProperty = self.properties.getProperty(byIndex: indexPath.row)
//        self.delegate?.propertySelected(newProperty: selectedProperty)
//        splitViewController?.showDetailViewController(appDelegate.propertyDetailViewController, sender: nil)
    }
}

extension PropertyListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.properties.getAllProperties().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell:PropertyCell = tableView.dequeueReusableCell(withIdentifier: "PropertyCell") as? PropertyCell else {return PropertyCell()}
        let property = self.properties.getProperty(byIndex: indexPath.row)
        cell.addressLabel?.text = property.getAddress()
        cell.priceLabel?.text = property.getPrice(formatted: true)
        cell.progressPriceLabel?.text = property.getProgressPrice(formatted: true)
        cell.progressBar?.setProgress(Float(property.getProgressPrice() / property.getPrice()), animated: true)
        cell.propertyImage?.downloadedFrom(link: property.getImageURL(), contentMode: .scaleAspectFill)
        cell.bar?.backgroundColor = Color.white
        return cell
    }
}

extension PropertyListViewController {
    @objc
    fileprivate func handleMenuButton() {
        navigationDrawerController?.toggleLeftView()
    }
}
