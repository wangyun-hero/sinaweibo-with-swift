//
//  WYHomeTableViewController.swift
//  sinaweibo
//
//  Created by 王云 on 16/8/29.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit

class WYHomeTableViewController: WYVisitorViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       setupUI()
        
    }
    
    
  private  func setupUI () {
        //本身并不提供设置图片的方法,我们将设置btn,然后设置到 UIBarButtonItem   的costomview上
//        let button = UIButton()
//        button.setImage(#imageLiteral(resourceName: "navigationbar_friendsearch"), for: UIControlState.normal)
//        button.setImage(#imageLiteral(resourceName: "navigationbar_friendsearch_highlighted"), for: UIControlState.highlighted)
//        button.sizeToFit()
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendsearch", target: nil, action: nil)
    
    //点击右边item跳转
    navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop", target: self, action: #selector(pop))
    
    }
    
    func pop(){
        print(#function)
        let vc = WYTempViewController()
        //vc.navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_back_withtext", title: "返回", target: self, action: #selector(back))
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func back () {
       _ = navigationController?.popViewController(animated: true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
