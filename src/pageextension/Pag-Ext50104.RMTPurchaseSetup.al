pageextension 50104 "RMTPurchaseSetup" extends "Purchases & Payables Setup"
{
  layout
  {
    // Add changes to page layout here
    addafter("Ignore Updated Addresses")
    {
      field("RMT PR Dummy Vendor";rec."RMT PR Dummy Vendor")
      {
        ApplicationArea = All;
      }
      field("RMT Vendor For RFQ";"RMT Vendor For RFQ")
      {
        ApplicationArea = All;
      }
      field("RMT Request Location";"RMT Request Location")
      {
        ApplicationArea = All;
      }
      field("RMT Disable Purchase Qoute";"RMT Disable Qoute")
      {
        ApplicationArea = All;
      }
    }
    addafter("Vendor Nos.")
    {
      field("RMT Requisition Nos.";"RMT Requisition Nos.")
      {
        ApplicationArea = All;
      }
      field("RMT Request for quote Nos.";"RMT Request for quote Nos.")
      {
        ApplicationArea = All;
      }
    }
  }
  var myInt: Integer;
}
