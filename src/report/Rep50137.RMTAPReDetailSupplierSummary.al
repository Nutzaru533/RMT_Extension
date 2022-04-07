report 50137 "RMT AP ReDetailSupplierSummary"
{
  Caption = 'AP Receiving Detail by Supplier Summary';
  UsageCategory = Administration;
  ApplicationArea = All;
  DefaultLayout = RDLC;
  RDLCLayout = 'Report/Layout/AP_ReDetailSupplierSummary.rdl';

  dataset
  {
  dataitem(PurchrecptLine;
  "Purch. Rcpt. Line")
  {
  RequestFilterFields = "Posting Date";
  DataItemTableView = where(quantity=filter(<>0));

  column(VendorNo;
  "Pay-to Vendor No.")
  {
  }
  column(Vendor;
  Vendor.Name)
  {
  }
  column(Line_No_;
  "Line No.")
  {
  }
  column(ItemNo;
  "No.")
  {
  }
  column(Description;
  Description)
  {
  }
  column(Location_Code;
  "Location Code")
  {
  }
  column(locationName;
  location.Name)
  {
  }
  column(RecNo;
  "Document No.")
  {
  }
  column(Posting_Date;
  "Expected Receipt Date")
  {
  }
  column(PoNo;
  "Order No.")
  {
  }
  column(InvoiceNo;
  PurchaseInvLine."Document No.")
  {
  }
  column(TypeTxt;
  TypeTxt)
  {
  }
  column(Unit_of_Measure;
  "Unit of Measure")
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
  column(Discount;
  PurchaseLine."Inv. Discount Amount")
  {
  }
  column(Amount;
  PurchaseLine.Amount)
  {
  }
  column(AmountIncVat;
  PurchaseLine."Amount Including VAT")
  {
  }
  column(Vat;
  PurchaseLine."Amount Including VAT" - PurchaseLine.Amount)
  {
  }
  column(Picture;
  companyinfo.Picture)
  {
  }
  column(companyinfoname;
  companyinfo.Name)
  {
  }
  column(CountNo;
  CountNo)
  {
  }
  trigger OnAfterGetRecord()var myInt: Integer;
  begin
    CountNo+=1;
    companyinfo.reset;
    companyinfo.get();
    companyinfo.CalcFields(Picture);
    if not vendor.get("Pay-to Vendor No.")then vendor.init;
    PurchaseInvLine.reset;
    PurchaseInvLine.SetRange("Receipt No.", "Document No.");
    PurchaseInvLine.SetRange("Receipt Line No.", "Line No.");
    if not PurchaseInvLine.Find('-')then PurchaseInvLine.init;
    item.reset;
    if item.get("No.")then begin
      if item.Type = item.Type::Inventory then TypeTxt:='I'
      else
        TypeTxt:='E';
    end
    else
      TypeTxt:='E';
    PurchaseLine.reset;
    PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::order);
    PurchaseLine.SetRange("Document No.", "Order No.");
    PurchaseLine.SetRange("Line No.", "Order Line No.");
    if not PurchaseLine.Find('-')then PurchaseLine.init;
    location.reset;
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
  var Vendor: Record Vendor;
  PurchaseInvLine: Record "Purch. Inv. Line";
  PurchaseLine: Record "Purchase Line";
  TypeTxt: Text[10];
  item: Record item;
  companyinfo: Record "Company Information";
  CountNo: Integer;
  location: Record Location;
}
