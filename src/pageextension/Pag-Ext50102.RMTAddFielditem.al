pageextension 50102 "RMT_AddField_item" extends "Item list"
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
