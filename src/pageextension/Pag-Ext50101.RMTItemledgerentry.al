pageextension 50101 "RMT Itemledgerentry" extends "Item Ledger Entries"
{
  layout
  {
    // Add changes to page layout here
    addafter("Location Code")
    {
      field("Qty.per Unit of Measure";"Qty. per Unit of Measure")
      {
        ApplicationArea = All;
      }
    }
  }
  var myInt: Integer;
}
