report 50148 "RMT Purchase Compare Price"
{
  UsageCategory = Administration;
  ApplicationArea = All;
  Caption = 'Purchase Compare Price';
  DefaultLayout = RDLC;
  RDLCLayout = 'Report/Layout/RMTPurchaseComparePrice.rdl';

  dataset
  {
  dataitem(PurchaseHeader;
  "Purchase Header")
  {
  RequestFilterFields = "No.";

  column(No_;
  "No.")
  {
  }
  column(CompanyinfoName;
  Companyinfo.Name)
  {
  }
  column(CompanyinfoName2;
  Companyinfo."Name 2")
  {
  }
  column(CompanyinfoAdress;
  Companyinfo.Address)
  {
  }
  column(CompanyinfoAdress2;
  Companyinfo."Address 2")
  {
  }
  column(CompanyinfoCity;
  Companyinfo.City)
  {
  }
  column(CompanyinfoCounty;
  Companyinfo.County)
  {
  }
  column(CompanyinfoPostcode;
  Companyinfo."Post Code")
  {
  }
  column(Document_Date;
  "Document Date")
  {
  }
  column(RMTVendorNo1_PurchaseHeader;
  "RMT Vendor No. 1")
  {
  }
  column(RMTVendorNo2_PurchaseHeader;
  "RMT Vendor No. 2")
  {
  }
  column(RMTVendorNo3_PurchaseHeader;
  "RMT Vendor No. 3")
  {
  }
  column(RMTVendorNo5_PurchaseHeader;
  "RMT Vendor No. 5")
  {
  }
  column(RMTVendorNo4_PurchaseHeader;
  "RMT Vendor No. 4")
  {
  }
  column(RMTVendorName1_PurchaseHeader;
  "RMT Vendor Name 1")
  {
  }
  column(RMTVendorName2_PurchaseHeader;
  "RMT Vendor Name 2")
  {
  }
  column(RMTVendorName3_PurchaseHeader;
  "RMT Vendor Name 3")
  {
  }
  column(RMTVendorName4_PurchaseHeader;
  "RMT Vendor Name 4")
  {
  }
  column(RMTVendorName5_PurchaseHeader;
  "RMT Vendor Name 5")
  {
  }
  column(RMT_Remark;
  "RMT Remark")
  {
  }
  trigger OnAfterGetRecord()var myInt: Integer;
  begin
    Companyinfo.get;
  end;
  }
  dataitem(PurchaseLine;
  "Purchase Line")
  {
  DataItemLinkReference = PurchaseHeader;
  DataItemLink = "Document No."=field("No."), "Document type"=field("Document Type");

  column(Rmt_itemNo;
  "RMT Item No.")
  {
  }
  column(RMT_Selected_Vendor_No_;
  "RMT Selected Vendor No.")
  {
  }
  column(Description_PurchaseLine;
  Description)
  {
  }
  column(RMTQuantity_PurchaseLine;
  "RMT Quantity")
  {
  }
  column(RMTVendorNo1_PurchaseLine;
  "RMT Vendor No.1")
  {
  }
  column(RMTVendorNo2_PurchaseLine;
  "RMT Vendor No.2")
  {
  }
  column(RMTVendorNo3_PurchaseLine;
  "RMT Vendor No.3")
  {
  }
  column(RMTVendorNo4_PurchaseLine;
  "RMT Vendor No.4")
  {
  }
  column(RMTVendorNo5_PurchaseLine;
  "RMT Vendor No.5")
  {
  }
  column(RMTVendorPrice1_PurchaseLine;
  "RMT Vendor Price 1")
  {
  }
  column(RMTVendorPrice2_PurchaseLine;
  "RMT Vendor Price 2")
  {
  }
  column(RMTVendorPrice3_PurchaseLine;
  "RMT Vendor Price 3")
  {
  }
  column(RMTVendorPrice4_PurchaseLine;
  "RMT Vendor Price 4")
  {
  }
  column(RMTVendorPrice5_PurchaseLine;
  "RMT Vendor Price 5")
  {
  }
  column(Line_No_;
  "Line No.")
  {
  }
  column(NewLineNo;
  NewLineNo)
  {
  }
  column(RMT_Unit_of_Measure;
  "RMT Unit of Measure")
  {
  }
  trigger OnAfterGetRecord()var myInt: Integer;
  begin
    if "RMT Item No." <> '' then NewLineNo+=1;
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
  var Companyinfo: Record "Company Information";
  NewLineNo: Integer;
}
