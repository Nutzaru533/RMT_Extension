pageextension 50109 "RMT Goods Receipt Note Card" extends "Goods Receipt Note Card"
{
  layout
  {
    // Add changes to page layout here
    addafter("Location Code")
    {
      field("Shortcut Dimension 1 Code1";"Shortcut Dimension 1 Code")
      {
        ApplicationArea = All;
      }
      field("Shortcut Dimension 2 Code1";"Shortcut Dimension 2 Code")
      {
        ApplicationArea = All;
      }
    }
  }
  var myInt: Integer;
}
