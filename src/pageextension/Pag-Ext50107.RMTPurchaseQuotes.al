pageextension 50107 "RMT_PurchaseQuotes" extends "Purchase Quotes"
{
  trigger OnOpenPage()var myInt: Integer;
  begin
    PurchaseSetup.get;
    if PurchaseSetup."RMT Disable Qoute" then error('Please Open in Purchase Request !!!!!!');
  end;
  var PurchaseSetup: Record "Purchases & Payables Setup";
}
