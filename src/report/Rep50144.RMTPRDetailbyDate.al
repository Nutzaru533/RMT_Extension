report 50144 "RMT PR Detail by Date"
{
  Caption = 'PR Detail by Date';
  UsageCategory = Administration;
  ApplicationArea = All;
  DefaultLayout = RDLC;
  RDLCLayout = 'Report/Layout/PR_DetailByDate.rdl';

  dataset
  {
  dataitem("Purchase Header";
  "Purchase Header")
  {
  DataItemTableView = sorting("NO.")where("Document Type"=CONST(Quote));
  //, "RMT Request for Quote" = filter(true));
  RequestFilterFields = "Document Date";

  column(companyinfoPicture;
  companyinfo.Picture)
  {
  }
  column(companyinfoName;
  companyinfo.Name)
  {
  }
  column(DocumentDate;
  "Document Date")
  {
  }
  column(dim1;
  "Shortcut Dimension 1 Code")
  {
  }
  column(dim1Des;
  dimensionValue.Name)
  {
  }
  column(dim2;
  "Shortcut Dimension 2 Code")
  {
  }
  column(Remark;
  Remark)
  {
  }
  column(Location;
  location.Name)
  {
  }
  dataitem("Purchaser Line";
  "Purchase Line")
  {
  DataItemLinkReference = "Purchase Header";
  DataItemLink = "Document No."=field("No."), "Document type"=field("Document Type");

  //DataItemTableView = sorting("Document No.") where("Document Type" = CONST(Quote), "RMT Request for Quote" = filter(true));
  column(DocumentNo;
  "Document No.")
  {
  }
  column(estimateReceiptDate;
  PurchaseHeader."Expected Receipt Date")
  {
  }
  column(Location_Code;
  location2.Name)
  {
  }
  column(No_;
  "No.")
  {
  }
  column(Description;
  Description)
  {
  }
  column(item;
  item.Inventory)
  {
  }
  column(Quantity;
  Quantity)
  {
  }
  column(Direct_Unit_Cost;
  "Direct Unit Cost")
  {
  }
  column(Line_No_;
  "Line No.")
  {
  }
  trigger OnAfterGetRecord()var begin
    PurchaseHeader.reset;
    if not PurchaseHeader.get("Document Type", "Document No.")then PurchaseHeader.init;
    item.Reset();
    if not item.get("No.")then item.init;
    item.CalcFields(Inventory);
    location2.reset;
    if not location2.get("Location Code")then location2.init;
  end;
  }
  trigger OnAfterGetRecord()var begin
    PurchCommentLine.reset;
    PurchCommentLine.SetRange("Document Type", PurchCommentLine."Document Type"::Quote);
    PurchCommentLine.SetRange("No.", "No.");
    PurchCommentLine.SetFilter(Comment, '<>%1', '');
    if PurchCommentLine.find('-')then begin
      Remark:=PurchCommentLine.Comment;
    end;
    companyinfo.get;
    companyinfo.CalcFields(Picture);
    dimensionValue.reset;
    dimensionValue.SetRange("Dimension Code", "Shortcut Dimension 1 Code");
    if dimensionValue.Find('-')then location.reset;
    if not location.get("Location Code")then location.init;
  end;
  }
  }
  requestpage
  {
    layout
    {
      area(Content)
      {
        group(GroupName)
        {
        // field(Name; SourceExpression)
        // {
        //     ApplicationArea = All;
        // }
        }
      }
    }
    actions
    {
      area(processing)
      {
        action(ActionName)
        {
          ApplicationArea = All;
        }
      }
    }
  }
  var PurchaseHeader: Record "Purchase Header";
  item: Record item;
  location2: Record Location;
  PurchCommentLine: Record "Purch. Comment Line";
  OldNo: Code[20];
  Remark: Text[100];
  companyinfo: Record "Company Information";
  dimensionValue: Record "Dimension Value";
  location: Record Location;
}
