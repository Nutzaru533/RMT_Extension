page 50106 "RMT History PO"
{
  Caption = 'History PO';
  PageType = List;
  ApplicationArea = All;
  UsageCategory = Lists;
  SourceTable = "Purchase Line";
  SourceTableView = where("RMT Purchase Request No."=filter(<>''));

  layout
  {
    area(content)
    {
      repeater(Control1)
      {
        field("Document No.";Rec."Document No.")
        {
          ToolTip = 'Specifies the value of the Document No. field';
          ApplicationArea = All;
        }
        field("RMT Purchase Request No.";Rec."RMT Purchase Request No.")
        {
          ToolTip = 'Specifies the value of the Purchase Request No. field';
          ApplicationArea = All;
        }
        field("No.";Rec."No.")
        {
          ToolTip = 'Specifies the value of the No. field';
          ApplicationArea = All;
        }
        field("Buy-from Vendor No.";Rec."Buy-from Vendor No.")
        {
          ToolTip = 'Specifies the value of the Buy-from Vendor No. field';
          ApplicationArea = All;
        }
        field(Description;Rec.Description)
        {
          ToolTip = 'Specifies the value of the Description field';
          ApplicationArea = All;
        }
        field("Description 2";Rec."Description 2")
        {
          ToolTip = 'Specifies the value of the Description 2 field';
          ApplicationArea = All;
        }
        field("Expected Receipt Date";Rec."Expected Receipt Date")
        {
          ToolTip = 'Specifies the value of the Expected Receipt Date field';
          ApplicationArea = All;
        }
        field(Quantity;Rec.Quantity)
        {
          ToolTip = 'Specifies the value of the Quantity field';
          ApplicationArea = All;
        }
        field("Unit of Measure Code";Rec."Unit of Measure Code")
        {
          ToolTip = 'Specifies the value of the Unit of Measure Code field';
          ApplicationArea = All;
        }
        field("Direct Unit Cost";Rec."Direct Unit Cost")
        {
          ToolTip = 'Specifies the value of the Direct Unit Cost field';
          ApplicationArea = All;
        }
        field(Amount;Rec.Amount)
        {
          ToolTip = 'Specifies the value of the Amount field';
          ApplicationArea = All;
        }
        field("Amount Including VAT";Rec."Amount Including VAT")
        {
          ToolTip = 'Specifies the value of the Amount Including VAT field';
          ApplicationArea = All;
        }
        field("Receipt No.";Rec."Receipt No.")
        {
          ToolTip = 'Specifies the value of the Receipt No. field';
          ApplicationArea = All;
        }
        field("Receipt Line No.";Rec."Receipt Line No.")
        {
          ToolTip = 'Specifies the value of the Receipt Line No. field';
          ApplicationArea = All;
        }
      }
    }
  }
  actions
  {
    area(Processing)
    {
      action(ActionName)
      {
        ApplicationArea = All;
        Caption = 'Open Document';
        Promoted = true;
        PromotedCategory = Process;
        Image = Document;
        RunObject = page "Purchase Order";
        RunPageLink = "No."=field("Document No."), "Document Type"=field("Document Type");
      }
    }
  }
  var myInt: Integer;
}
