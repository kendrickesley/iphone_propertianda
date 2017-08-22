//
//  PropertyListViewController.swift
//  Properti Anda
//
//  Created by Kendrick on 22/8/17.
//  Copyright © 2017 Kendrick. All rights reserved.
//

import UIKit
import Material

class PropertyListViewController: UIViewController {
    @IBOutlet weak var propertyTableView:UITableView!
    fileprivate var menuButton: IconButton!
    let properties:Properties = Properties()
    override func viewDidLoad() {
        super.viewDidLoad()
        propertyTableView.dataSource = self
        propertyTableView.delegate = self
        prepareMenuButton()
        prepareNavigationItem()
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

}

extension PropertyListViewController: UITableViewDelegate{
    
}

extension PropertyListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.properties.getAllProperties().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell:PropertyCell = tableView.dequeueReusableCell(withIdentifier: "PropertyCell") as? PropertyCell else {return PropertyCell()}
        let property = self.properties.getProperty(byIndex: indexPath.row)
//        cell.addressLabel?.text = property.getAddress()
//        cell.priceLabel?.text = property.getPrice(formatted: true)
//        cell.progressPriceLabel?.text = property.getProgressPrice(formatted: true)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension PropertyListViewController {
    @objc
    fileprivate func handleMenuButton() {
        navigationDrawerController?.toggleLeftView()
    }
}
