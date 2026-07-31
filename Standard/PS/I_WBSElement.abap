CDS         :   I_WBSElement
Description :   WBS Element Details

Using       :   left outer join I_WBSElement as WBSElement on WBSElement.WBSElementInternalID = matdoc.mat_pspnr

Fields      :   key WBSElement,
                    
                    WBSElementInternalID
Where       :   

Group       :   

Module           :   PS
Business Object  :   WBS Element
Common Use Cases :   - Link material document (matdoc) postings to their WBS element for project cost reporting
Related CDS      :   I_ProjectElement, I_Project