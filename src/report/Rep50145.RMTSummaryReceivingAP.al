report 50145 "RMT_Summary Receiving AP"
{
  Caption = 'Summary Receiving (AP)';
  UsageCategory = Administration;
  ApplicationArea = All;
  DefaultLayout = RDLC;
  RDLCLayout = 'Report/Layout/Summary_Receiveing_AP2.rdl';

  dataset
  {
  dataitem(PurchaseInv;
  "Purch. Rcpt. Header")
  {
  DataItemTableView = sorting("No.", "Expected Receipt Date");
  RequestFilterFields = "Expected Receipt Date", "Buy-from Vendor No.";

  column(Posting_Date;
  "Expected Receipt Date")
  {
  }
  column(RecNo;
  "No.")
  {
  }
  column(PoDoc;
  "Order No.")
  {
  }
  column(PInvDoc;
  PInvDoc)
  {
  }
  column(PRDoc;
  PRDoc)
  {
  }
  column(SystemModifiedBy;
  PurchaseInv."User ID")
  {
  }
  column(NETAmount;
  NETAmount)
  {
  }
  column(VatAmount;
  VatAmount)
  {
  }
  column(AmountIncVat;
  AmountIncVat)
  {
  }
  column(CompanyinfoName;
  Companyinfo.Name)
  {
  }
  column(CompanyinfoPic;
  Companyinfo.Picture)
  {
  }
  column(Reportfilter;
  PurchaseInv.GetFilters())
  {
  }
  column(vendorname;
  vendor.Name)
  {
  }
  trigger OnPreDataItem()var myInt: Integer;
  begin
  end;
  trigger OnAfterGetRecord()var myInt: Integer;
  begin
    Companyinfo.get;
    Companyinfo.CalcFields(Picture);
    Clear(PRDoc);
    Clear(NETAmount);
    Clear(VatAmount);
    Clear(AmountIncVat);
    //CalcFields(Amount, "Amount Including VAT");
    // NETAmount := Amount;
    // VatAmount := "Amount Including VAT" - Amount;
    // AmountIncVat := "Amount Including VAT";
    if not vendor.get("Pay-to Vendor No.")then vendor.init;
    //get invoice
    PurchInvline.reset;
    PurchInvline.SetRange("Receipt No.", "No.");
    PurchInvline.SetFilter("No.", '<>%1', '');
    if PurchInvline.Find('-')then begin
      PInvDoc:=PurchInvline."Document No.";
    end;
    //get invoice
    // PurchReceipt.reset;
    // PurchReceipt.SetRange("Order No.", "No.");
    // if PurchReceipt.Find('-') then begin
    //     PONO := PurchReceipt."Order No.";
    // end;
    //get PO 
    PurchaseHeader.reset;
    if PurchaseHeader.get(PurchaseHeader."Document Type"::Order, "Order No.")then begin
      PurchaseLine.reset;
      PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
      PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
      if PurchaseLine.Find('-')then begin
        PRDoc:=PurchaseHeader."Quote No.";
        repeat if PurchaseHeader."Prices Including VAT" then begin
            unitprice:=PurchaseLine."Direct Unit Cost";
            CalAmount:=unitprice * PurchaseLine.Quantity;
            if PurchaseLine."VAT %" <> 0 then CalVat:=Round(CalAmount * PurchaseLine."VAT %" / 107);
            CalAmount:=CalAmount - CalVat;
            CalAmountVat:=CalAmount + CalVat;
          end
          else
          begin
            unitprice:=PurchaseLine."Direct Unit Cost";
            CalAmount:=unitprice * PurchaseLine.Quantity;
            if PurchaseLine."VAT %" <> 0 then CalVat:=Round(CalAmount * PurchaseLine."VAT %" / 100);
            CalAmountVat:=CalAmount + CalVat;
          end;
        until PurchaseLine.Next() = 0;
      end;
      NETAmount:=CalAmount;
      VatAmount:=CalVat;
      AmountIncVat:=CalAmountVat;
    end;
  //get PO
  //get pr
  end;
  }
  }
  requestpage
  {
    SaveValues = true;

    layout
    {
      area(Content)
      {
      // group(GroupName)
      // {
      //     field(Name; SourceExpression)
      //     {
      //         ApplicationArea = All;
      //     }
      // }
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
  var PRDoc: Code[20];
  RecNo: Code[20];
  PONO: Code[20];
  PurchInvline: Record "Purch. Inv. Line";
  PurchaseLine: Record "Purchase Line";
  NETAmount: Decimal;
  VatAmount: Decimal;
  AmountIncVat: Decimal;
  CalAmount: Decimal;
  unitprice: Decimal;
  CalAmountVat: Decimal;
  CalVat: Decimal;
  PurchaseHeader: Record "Purchase Header";
  Companyinfo: Record "Company Information";
  vendor: Record Vendor;
  PInvDoc: Code[50];
  PurchReceipt: Record "Purch. Rcpt. Header";
}
