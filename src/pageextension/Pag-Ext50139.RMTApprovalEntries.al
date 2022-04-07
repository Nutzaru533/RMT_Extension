pageextension 50139 "RMT_Approval Entries" extends "Approval Entries"
{
  layout
  {
    // Add changes to page layout here
    addbefore(Overdue)
    {
      field("Transection Reject By";Rec."Transection Reject By")
      {
        ToolTip = 'Specifies the value of the Approver ID field.';
        ApplicationArea = All;
      }
    }
  }
  var myInt: Integer;
}
