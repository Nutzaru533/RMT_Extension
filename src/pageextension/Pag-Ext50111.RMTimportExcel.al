pageextension 50111 "RMT_importExcel" extends "Import Excel"
{
  actions
  {
    // Add changes to page actions here
    modify("Import Excel")
    {
      trigger OnBeforeAction()var myInt: Integer;
      begin
        Message('1');
      end;
    }
  }
  var myInt: Integer;
}
