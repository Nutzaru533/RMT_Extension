page 50107 "RMT Request for Quotes"
{
  AdditionalSearchTerms = 'rfq,request for quote,purchase requisition';
  ApplicationArea = Suite;
  Caption = 'Purchase Bidding Price';
  CardPageID = "RMT RequestforQuote";
  DataCaptionFields = "Buy-from Vendor No.";
  Editable = false;
  PageType = List;
  PromotedActionCategories = 'New,Process,Report,Request Approval,Print/Send,Quote';
  QueryCategory = 'Request for Quote';
  RefreshOnActivate = true;
  SourceTable = "Purchase Header";
  SourceTableView = WHERE("Document Type"=CONST(Quote), "RMT Request for Quote"=filter(true));
  UsageCategory = Lists;

  layout
  {
    area(content)
    {
      repeater(Control1)
      {
        ShowCaption = false;

        field("No.";"No.")
        {
          ApplicationArea = Suite;
          ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
        }
        field("RMT Vendor No. 1";Rec."RMT Vendor No. 1")
        {
          ToolTip = 'Specifies the value of the Vendor No. 1 field';
          ApplicationArea = All;
        }
        field("RMT Vendor Name 1";Rec."RMT Vendor Name 1")
        {
          ToolTip = 'Specifies the value of the Vendor Name 1 field';
          ApplicationArea = All;
        }
        field("RMT Vendor No. 2";Rec."RMT Vendor No. 2")
        {
          ToolTip = 'Specifies the value of the Vendor No. 2 field';
          ApplicationArea = All;
        }
        field("RMT Vendor Name 2";Rec."RMT Vendor Name 2")
        {
          ToolTip = 'Specifies the value of the Vendor Name 2 field';
          ApplicationArea = All;
        }
        field("RMT Vendor No. 3";Rec."RMT Vendor No. 3")
        {
          ToolTip = 'Specifies the value of the Vendor No. 3 field';
          ApplicationArea = All;
        }
        field("RMT Vendor Name 3";Rec."RMT Vendor Name 3")
        {
          ToolTip = 'Specifies the value of the Vendor Name 3 field';
          ApplicationArea = All;
        }
        field("RMT Vendor No. 4";Rec."RMT Vendor No. 4")
        {
          ToolTip = 'Specifies the value of the Vendor No. 4 field';
          ApplicationArea = All;
        }
        field("RMT Vendor Name 4";Rec."RMT Vendor Name 4")
        {
          ToolTip = 'Specifies the value of the Vendor Name 4 field';
          ApplicationArea = All;
        }
        field("RMT Vendor No. 5";Rec."RMT Vendor No. 5")
        {
          ToolTip = 'Specifies the value of the Vendor No. 5 field';
          ApplicationArea = All;
        }
        field("RMT Vendor Name 5";Rec."RMT Vendor Name 5")
        {
          ToolTip = 'Specifies the value of the Vendor Name 5 field';
          ApplicationArea = All;
        }
        field("Status";"Status")
        {
          ApplicationArea = All;
        }
      }
    }
  }
}
