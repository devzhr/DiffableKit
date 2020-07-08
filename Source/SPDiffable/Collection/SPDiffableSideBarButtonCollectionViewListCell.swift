// The MIT License (MIT)
// Copyright © 2020 Ivan Vorobei (varabeis@icloud.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit

/**
 List class using for ovveride logic of text color.
 
 When change state, here using custom processing of title color. It depended of state.
 Also not show background selection, but cell selected. Need deselect it manually.
 Configure it cell need via `updateWithItem` func.
 */
@available(iOS 14, *)
class SPDiffableSideBarButtonCollectionViewListCell: UICollectionViewListCell {
    
    private var item: SPDiffableSideBarButton? = nil
    
    func updateWithItem(_ newItem: SPDiffableSideBarButton) {
        guard item != newItem else { return }
        item = newItem
        setNeedsUpdateConfiguration()
    }
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        var content = UIListContentConfiguration.sidebarCell().updated(for: state)
        content.text = item?.title
        content.image = item?.image
        
        content.textProperties.color = tintColor
        content.imageProperties.tintColor = tintColor
        
        if state.isHighlighted {
            content.textProperties.color = .tertiaryLabel
            content.imageProperties.tintColor = .tertiaryLabel
        }

        contentConfiguration = content
        backgroundConfiguration?.backgroundColor = .clear
    }
}


