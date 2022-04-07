report 50143 "RMT ReceivedDetailbySupplier"
{
  Caption = 'Received Detail by Supplier';
  UsageCategory = Administration;
  ApplicationArea = All;
  DefaultLayout = RDLC;
  RDLCLayout = 'Report/Layout/ReceivedDetailbySupplier.rdl';

  dataset
  {
  dataitem(PurchRcptHeader;
  "Purch. Rcpt. Header")
  {
  RequestFilterFields = "Expected Receipt Date", "Order No.", "No.";

  dataitem(PurchrecptLine;
  "Purch. Rcpt. Line")
  {
  //RequestFilterFields = "Posting Date", "Order No.", "Document No.";
  DataItemTableView = where(quantity=filter(<>0));
  DataItemLink = "Document No."=field("No.");

  column(ColumnName;
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
  column(RecNo;
  "Document No.")
  {
  }
  column(Posting_Date;
  "Posting Date")
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
  Amount)
  {
  }
  column(AmountIncVat;
  AmountIncVat)
  {
  }
  column(Vat;
  Vat)
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
    if Quantity < 0 then begin
      PurchaseLine."Amount Including VAT":=PurchaseLine."Amount Including VAT" * -1;
      PurchaseLine.Amount:=PurchaseLine.Amount * -1;
    end;
    // Amount := PurchaseLine.Amount;
    // AmountIncVat := PurchaseLine."Amount Including VAT";
    clear(Amount);
    Clear(AmountIncVat);
    Clear(Discount);
    Clear(Vat);
    if Amount = 0 then Amount:="Direct Unit Cost" * Quantity;
    if AmountIncVat = 0 then begin
      if "VAT %" > 0 then AmountIncVat:=Amount + Round(Amount * 7 / 100)
      else
        AmountIncVat:=Amount;
    end;
    if Quantity < 0 then begin
      Amount:=Amount * -1;
      AmountIncVat:=AmountIncVat * -1;
    end;
    Discount:=PurchaseLine."Inv. Discount Amount";
    Vat:=AmountIncVat - Amount;
  end;
  }
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
  Amount: Decimal;
  AmountIncVat: Decimal;
  Discount: Decimal;
  Vat: Decimal;
}
