//
//  PropertyDetailViewController.swift
//  Properti Anda
//
//  Created by Kendrick on 22/8/17.
//  Copyright © 2017 Kendrick. All rights reserved.
//

import UIKit
import Material
import GoogleMaps
import SwiftSpinner

class PropertyDetailViewController: UIViewController {

    public var property:Property?{
        didSet{
            self.updateScreen()
        }
    }
    
    private var showMore = false
    
    @IBOutlet weak var addressLabel:UILabel?
    @IBOutlet weak var emptyView:UIView?
    @IBOutlet weak var propertyScrollView:UIScrollView?
    @IBOutlet weak var propertyImage:UIImageView?
    @IBOutlet weak var propertyDetail:UILabel?
    @IBOutlet weak var investBtn:RaisedButton?
    @IBOutlet weak var myMapView:GMSMapView?
    @IBOutlet weak var showMoreBtn:UIButton?
    
    @IBOutlet weak var priceLabel:UILabel?
    @IBOutlet weak var fundedLabel:UILabel?
    @IBOutlet weak var investorsLabel:UILabel?
    
    @IBAction func showMoreClicked(){
        self.showMore = !self.showMore
        if showMore {
            self.showMoreBtn?.setTitle("Show Less", for: .normal)
            self.propertyDetail?.numberOfLines = 0
            self.propertyDetail?.lineBreakMode = .byWordWrapping
            self.propertyDetail?.sizeToFit()
        }else{
            self.showMoreBtn?.setTitle("Show More", for: .normal)
            self.propertyDetail?.numberOfLines = 2
            self.propertyDetail?.lineBreakMode = .byWordWrapping
            self.propertyDetail?.sizeToFit()
        }
    }
    
    @IBAction func showInvest(sender: AnyObject){
        self.performSegue(withIdentifier: "InvestBtnSegue", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "InvestBtnSegue" {
            guard let object = self.property else { return }
            let vc = segue.destination as! InvestViewController
            vc.property = object
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareNavigationBar()
        updateScreen()
        SwiftSpinner.setTitleFont(UIFont(name: "Helvetica Neue", size: 22.0))
        if self.property != nil {
            propertyScrollView?.alpha = 1.0
            emptyView?.alpha = 0
        }else{
            emptyView?.alpha = 1.0
            propertyScrollView?.alpha = 0
        }
        let camera = GMSCameraPosition.camera(withLatitude: 4.739001, longitude: -74.059616, zoom: 13)
        myMapView?.camera = camera
        
        self.propertyDetail?.numberOfLines = 2
        self.propertyDetail?.lineBreakMode = .byWordWrapping
        self.propertyDetail?.sizeToFit()
        self.propertyDetail?.text = ""
        self.showMoreBtn?.alpha = 0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func prepareNavigationBar(){
        navigationItem.title = "Property Detail"
        navigationItem.detail = ""
        navigationItem.titleLabel.textColor = Color.white
        navigationItem.detailLabel.textColor = Color.white
        navigationItem.backBarButtonItem?.tintColor = Color.white
        navigationItem.backButton.tintColor = Color.white
    }
    
    func updateScreen(){
        if self.property == nil {
            return
        }
        SwiftSpinner.show("Requesting details...")
        self.property?.requestDetail(callback: {
            self.showMoreBtn?.alpha = 1.0
            self.propertyDetail?.attributedText = self.stringFromHtml(string: self.property?.getDetail() ?? "No details provided")
            self.myMapView?.animate(toLocation: CLLocationCoordinate2DMake(self.property?.getLatitude() ?? 0, self.property?.getLongitude() ?? 0))
            self.myMapView?.animate(toZoom: 13)
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2DMake(self.property?.getLatitude() ?? 0, self.property?.getLongitude() ?? 0)
            marker.snippet = self.property?.address ?? "Property address"
            marker.appearAnimation = .pop
            marker.map = self.myMapView
            SwiftSpinner.hide()
            return ""
        })
        navigationItem.detail = self.property?.getAddress() ?? ""
        self.addressLabel?.text = self.property?.getAddress() ?? "Default Address"
        self.priceLabel?.text = self.property?.getPrice(formatted: true) ?? ""
        self.fundedLabel?.text = self.property?.getProgressPrice(formatted: true, independent: true)
        self.investorsLabel?.text = self.property?.getInvestors() ?? "0"
        self.propertyImage?.downloadedFrom(link: (self.property?.getImageURL())!)
    }
    
    private func stringFromHtml(string: String) -> NSAttributedString? {
        do {
            let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
            if let d = data {
                let str = try NSAttributedString(data: d,
                                                 options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
                                                 documentAttributes: nil)
                return str
            }
        } catch {
        }
        return nil
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

