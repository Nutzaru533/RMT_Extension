report 50141 "RMT PO Summary by Date"
{
  Caption = 'PO Summary by Date';
  UsageCategory = Administration;
  ApplicationArea = All;
  DefaultLayout = RDLC;
  RDLCLayout = 'Report/Layout/POSummarybyDate.rdl';

  dataset
  {
  dataitem("Purchase Header";
  "Purchase Header")
  {
  DataItemTableView = sorting("No.")where("Document Type"=const(Order));
  RequestFilterFields = "Document Date";
  CalcFields = Amount, "Amount Including VAT";

  column(No;
  "No.")
  {
  }
  column(Document_Date;
  "Document Date")
  {
  }
  column(Buy_from_Vendor_No_;
  "Buy-from Vendor No.")
  {
  }
  column(Buy_from_Vendor_Name;
  "Buy-from Vendor Name")
  {
  }
  column(Amount;
  Amount)
  {
  }
  column(Amount_Including_VAT;
  "Amount Including VAT")
  {
  }
  column(Vatamt;
  "Amount Including VAT" - Amount)
  {
  }
  column(TotalDiscount;
  TotalDiscount)
  {
  }
  column(companyinfoName;
  companyinfo.Name)
  {
  }
  column(companyinfoPicture;
  companyinfo.Picture)
  {
  }
  column(datefilter;
  "Purchase Header".GetFilters())
  {
  }
  trigger OnPreDataItem()var myInt: Integer;
  begin
    companyinfo.get;
    companyinfo.CalcFields(Picture);
  end;
  trigger OnAfterGetRecord()var begin
    TotalDiscount:=0;
    PurchaseLine.reset;
    PurchaseLine.SetRange("Document Type", "Document Type");
    PurchaseLine.SetRange("Document No.", "No.");
    if PurchaseLine.Find('-')then begin
      PurchaseLine.CalcSums("Line Discount Amount");
      TotalDiscount:=PurchaseLine."Line Discount Amount";
    end;
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
  var PurchaseLine: Record "Purchase Line";
  TotalDiscount: Decimal;
  companyinfo: Record "Company Information";
}
