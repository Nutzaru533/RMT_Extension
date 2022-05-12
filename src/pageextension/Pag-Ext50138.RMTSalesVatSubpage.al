pageextension 50138 "RMT Sales Vat Subpage" extends "Sales Vat Subpage"
{
    layout
    {
        // Add changes to page layout here
    }

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