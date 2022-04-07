pageextension 50105 "RMT Puchase Order Sub" extends "Purchase Order Subform"
{
  layout
  {
    // Add changes to page layout here
    addafter("Description 2")
    {
      field("RMT Purchase Request No.";"RMT Purchase Request No.")
      {
        ApplicationArea = All;
      }
      field("RMT Purchase Request Line";"RMT Purchase Request Line")
      {
        ApplicationArea = All;
      }
    }
  }
  var myInt: Integer;
}
