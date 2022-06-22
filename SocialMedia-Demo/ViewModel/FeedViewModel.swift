//
//  HomeViewModel.swift
//  SocialMedia-Demo
//
//  Created by User on 21/06/22.
//

import Foundation
class FeedViewModel: NSObject {
    private var feedService: FeedServiceProtocol
    
    var reloadTableView: (() -> Void)?
    
    var feeds = Feeds()
    
    var feedCellViewModel = [FeedCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }

    init(feedService: FeedServiceProtocol = FeedsService()) {
        self.feedService = feedService
    }
    
    func getFeeds() {
        feedService.getFeeds { success, model, error in
            if success, let feeds = model {
                self.fetchData(feeds: feeds)
            } else {
                print(error!)
            }
        }
    }
    
    func fetchData(feeds: Feeds) {
        self.feeds = feeds
        var vms = [FeedCellViewModel]()
        for feed in feeds {
            vms.append(createCellModel(feed: feed))
        }
        feedCellViewModel = vms
    }
    
    func createCellModel(feed: Feed) -> FeedCellViewModel {
        let name = feed.user_name ?? ""
        let type =  feed.item_type ?? ""
        let content = feed.data ?? ""
        
        return FeedCellViewModel(name: name, postType: type, content: content)
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> FeedCellViewModel {
        return feedCellViewModel[indexPath.row]
    }
}


