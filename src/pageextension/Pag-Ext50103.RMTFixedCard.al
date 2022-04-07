pageextension 50103 "RMT FixedCard" extends "Fixed Asset Card"
{
  layout
  {
    // Add changes to page layout here
    addafter("Last Date Modified")
    {
      field("FA Posting Group";"FA Posting Group")
      {
        ApplicationArea = All;
      }
    }
  }
  var myInt: Integer;
}
