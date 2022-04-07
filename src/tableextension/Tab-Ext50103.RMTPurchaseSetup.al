tableextension 50103 "RMTPurchaseSetup" extends "Purchases & Payables Setup"
{
  fields
  {
    // Add changes to table fields here
    field(50101;"RMT PR Dummy Vendor";Code[20])
    {
      Caption = 'PR Dummuy Vendor No.';
      TableRelation = Vendor;
      DataClassification = ToBeClassified;
    }
    field(50102;"RMT Requisition Nos.";Code[20])
    {
      Caption = 'Requistion Nos';
      TableRelation = "No. Series";
      DataClassification = ToBeClassified;
    }
    field(50103;"RMT Vendor For RFQ";code[20])
    {
      Caption = 'Vendor For RFQ';
      TableRelation = Vendor;
      DataClassification = ToBeClassified;
    }
    field(50104;"RMT Request for quote Nos.";code[20])
    {
      TableRelation = "No. Series";
      Caption = 'Request for quote Nos.';
      DataClassification = ToBeClassified;
    }
    field(50105;"RMT Request Location";Code[20])
    {
      Caption = 'Request Location';
      TableRelation = Location;
      DataClassification = ToBeClassified;
    }
    field(50106;"RMT Disable Qoute";Boolean)
    {
      Caption = 'RMT Disable Purchase Qoute';
      DataClassification = ToBeClassified;
    }
  }
  var myInt: Integer;
}
