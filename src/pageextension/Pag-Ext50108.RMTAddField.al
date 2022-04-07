pageextension 50108 "RMT_AddField" extends "Item Card"
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
    }
  }
  var myInt: Integer;
}
