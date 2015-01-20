//
//  GatheringTableViewController.swift
//  gatherall2
//
//  Created by George on 1/19/15.
//  Copyright (c) 2015 George. All rights reserved.
//

import Foundation
import MapKit

class GatheringTableViewController : PFQueryTableViewController
{
    init()
    {
        super.init(style: UITableViewStyle.Plain, className: "Gathering")
        
        self.parseClassName = "Gathering"
        self.textKey = "name"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override func queryForTable() -> PFQuery!
    {
        var gatheringQuery = PFQuery(className: "Gathering")
        
        if (PFUser.currentUser() != nil)
        {
            gatheringQuery.whereKey("owner", equalTo: PFUser.currentUser())
        }
        else
        {
            gatheringQuery.whereKey("owner", equalTo: "") //probably not necessary anymore
        }
        return gatheringQuery
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 227.0
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!, object: PFObject!) -> PFTableViewCell!
    {
        var cell : GatheringCell? = tableView.dequeueReusableCellWithIdentifier("gatheringTableViewCell") as? GatheringCell
        
        if cell == nil
        {
            cell = GatheringCell(style: UITableViewCellStyle.Default, reuseIdentifier: "gatheringTableViewCell")
        }
        
        let geoPoint = object.objectForKey("location") as PFGeoPoint
        
        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: geoPoint.latitude, longitude: geoPoint.longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
        )
        
        NSLog(geoPoint.latitude.description)
        cell?.mapView?.setRegion(region, animated: false)
        
        return cell
    }
}
