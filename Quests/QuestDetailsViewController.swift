//
//  QuestDetailsViewController.swift
//  Quests
//
//  Created by Dmitry Valov on 04.01.2018.
//  Copyright © 2018 Ivan Akulov. All rights reserved.
//

import UIKit

class QuestDetailsViewController: UIViewController, UIScrollViewDelegate {
    
    var quest: Quest?
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLbel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var capacityLabel: UILabel!
    @IBOutlet weak var complexityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = quest?.name
        descriptionLbel.text = quest?.definition
        durationLabel.text = (quest?.duration)! + " минут"
        capacityLabel.text = (quest?.capacity)! + " игрока"
        complexityLabel.text = quest?.complexity
        
        self.scrollView.frame = CGRect(x:0, y:0, width:self.view.frame.width, height:self.scrollView.frame.height)
        let scrollViewWidth:CGFloat =  self.scrollView.frame.width
        let scrollViewHeight:CGFloat = self.scrollView.frame.height
        let images = (quest?.images)!
        
        for (index, image) in images.enumerated() {
            let img = UIImageView(frame: CGRect(x:scrollViewWidth * CGFloat(index), y:0,width:scrollViewWidth, height:scrollViewHeight))
            img.image = UIImage(named: image)
            img.contentMode = .scaleAspectFit
            img.backgroundColor = UIColor.black
            self.scrollView.addSubview(img)
        }
        
        self.scrollView.contentSize = CGSize(width:self.scrollView.frame.width * CGFloat(images.count), height:self.scrollView.frame.height)
        self.scrollView.delegate = self
        self.pageControl.numberOfPages = images.count
        self.pageControl.currentPage = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

private typealias ScrollView = QuestDetailsViewController
extension ScrollView
{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        // Test the offset and calculate the current page after scrolling ends
        let pageWidth:CGFloat = scrollView.frame.width
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        // Change the indicator
        self.pageControl.currentPage = Int(currentPage);
        // Change the text accordingly
        if Int(currentPage) == 0{
            //            textView.text = "Sweettutos.com is your blog of choice for Mobile tutorials"
        }else if Int(currentPage) == 1{
            //            textView.text = "I write mobile tutorials mainly targeting iOS"
        }else if Int(currentPage) == 2{
            //            textView.text = "And sometimes I write games tutorials about Unity"
        }else{
            //            textView.text = "Keep visiting sweettutos.com for new coming tutorials, and don't forget to subscribe to be notified by email :)"
            // Show the "Let's Start" button in the last slide (with a fade in animation)
            //            UIView.animate(withDuration: 1.0, animations: { () -> Void in
            //                self.startButton.alpha = 1.0
            //            })
        }
    }
}
