report 50135 "RMT_Summary Receiving AP2"
{
  Caption = 'Summary Receiving (AP) backup';
  // UsageCategory = Administration;
  // ApplicationArea = All;
  DefaultLayout = RDLC;
  RDLCLayout = 'Report/Layout/Summary_Receiveing_AP.rdl';

  dataset
  {
  dataitem(PurchaseInv;
  "Purch. Inv. Header")
  {
  DataItemTableView = sorting("No.", "Posting Date");
  RequestFilterFields = "Posting Date", "Buy-from Vendor No.";

  column(Posting_Date;
  "Posting Date")
  {
  }
  column(RecNo;
  RecNo)
  {
  }
  column(PoDoc;
  PONO)
  {
  }
  column(PInvDoc;
  "No.")
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
    CalcFields(Amount, "Amount Including VAT");
    NETAmount:=Amount;
    VatAmount:="Amount Including VAT" - Amount;
    AmountIncVat:="Amount Including VAT";
    if not vendor.get("Pay-to Vendor No.")then vendor.init;
    //get invoice
    PurchInvline.reset;
    PurchInvline.SetRange("Document No.", "No.");
    PurchInvline.SetFilter("No.", '<>%1', '');
    if PurchInvline.Find('-')then begin
      RecNo:=PurchInvline."Receipt No.";
    end;
    //get invoice
    PurchReceipt.reset;
    PurchReceipt.SetRange("No.", RecNo);
    if PurchReceipt.Find('-')then begin
      PONO:=PurchReceipt."Order No.";
    end;
    //get PO 
    PurchaseHeader.reset;
    if PurchaseHeader.get(PurchaseHeader."Document Type"::Order, PONO)then begin
      PurchaseLine.reset;
      PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
      PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
      if PurchaseLine.Find('-')then begin
        PRDoc:=PurchaseLine."RMT Purchase Request No.";
      end;
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
  PurchaseHeader: Record "Purchase Header";
  Companyinfo: Record "Company Information";
  vendor: Record Vendor;
  PurchReceipt: Record "Purch. Rcpt. Header";
}
