pageextension 50112 "RMT Purchase Vat Subpage" extends "Purchase Vat Subpage"
{
    actions
    {
        // Add changes to page actions here
        modify("Generate Vat Entry")
        {
            trigger OnBeforeAction()
            var
                myInt: Integer;
            begin
                //Message('1');
            end;
        }
    }
    var
        myInt: Integer;
}

