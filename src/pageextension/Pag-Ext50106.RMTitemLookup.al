pageextension 50106 "RMT_item Lookup" extends "Item Lookup"
{
  layout
  {
    // Add changes to page layout here
    addafter(Description)
    {
      field("Description 2";"Description 2")
      {
        ApplicationArea = All;
      }
      field("SearchDescription";"Search Description")
      {
        ApplicationArea = All;
      }
    }
  }
  var myInt: Integer;
}
