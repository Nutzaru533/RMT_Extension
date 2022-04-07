page 50104 "RMT Make PR to PO"
{
  Caption = 'Make PR to PO';
  PageType = Worksheet;
  //ApplicationArea = All;
  //UsageCategory = Lists;
  SourceTable = "Purchase Line";
  SourceTableView = WHERE("RMT Make TO PO"=const(false), "Document Type"=CONST(Quote), "RMT Purchase Request"=filter(true), Type=filter(<>''), "RMT PR Status"=const(Released));

  layout
  {
    area(content)
    {
      repeater(Control1)
      {
        ShowCaption = false;

        field("RMT Select PR to PO";rec."RMT Select PR to PO")
        {
          ToolTip = 'Specifies the value of the RMT Select PR to PO field';
          ApplicationArea = All;
        }
        field("Document No.";Rec."Document No.")
        {
          ToolTip = 'Specifies the value of the Document No. field';
          ApplicationArea = All;
          Editable = PRTOPO;
        }
        field("No.";Rec."No.")
        {
          ToolTip = 'Specifies the value of the No. field';
          ApplicationArea = All;
          Editable = PRTOPO;
        }
        field(Description;Rec.Description)
        {
          ToolTip = 'Specifies the value of the Description field';
          ApplicationArea = All;
          Editable = PRTOPO;
        }
        field("Location Code";Rec."Location Code")
        {
          ToolTip = 'Specifies the value of the Location Code field';
          ApplicationArea = All;
          Editable = PRTOPO;
        }
        field(Quantity;Rec.Quantity)
        {
          ToolTip = 'Specifies the value of the Quantity field';
          ApplicationArea = All;
          Editable = PRTOPO;
        }
        field("Unit of Measure Code";Rec."Unit of Measure Code")
        {
          ToolTip = 'Specifies the value of the Unit of Measure Code field';
          ApplicationArea = All;
          Editable = PRTOPO;
        }
        field("Direct Unit Cost";Rec."Direct Unit Cost")
        {
          ToolTip = 'Specifies the value of the Direct Unit Cost field';
          ApplicationArea = All;
          Editable = PRTOPO;
        }
        field("Line Amount";Rec."Line Amount")
        {
          ToolTip = 'Specifies the value of the Line Amount field';
          ApplicationArea = All;
          Editable = PRTOPO;
        }
        field("RMT PO Direct Unit Cost";"RMT PO Direct Unit Cost")
        {
          ApplicationArea = All;
        }
        field("RMT PO Line Amount";"RMT PO Line Amount")
        {
          ApplicationArea = All;
        }
        field("Buy-from Vendor No.";"Buy-from Vendor No.")
        {
          ApplicationArea = All;
          Editable = PRTOPO;
        }
        field("Expected Receipt Date";"Expected Receipt Date")
        {
          ApplicationArea = All;
          Editable = PRTOPO;
        }
        field("RMT Select Vendor No.";Rec."RMT Select Vendor No.")
        {
          ToolTip = 'Specifies the value of the RMT Select Vendor No. field';
          ApplicationArea = All;
        }
        field("RMT Select Vendor Name";"RMT Select Vendor Name")
        {
          ApplicationArea = All;
        }
        field("RMT PR Currency Code";"RMT PR Currency Code")
        {
          ApplicationArea = All;
        }
        field("RMT Qty. Make PO";"RMT Qty. Make PO")
        {
          ApplicationArea = All;
        }
        field("RMT PR Status";"RMT PR Status")
        {
          ApplicationArea = All;
        }
        field("RMT Qty. TO Po";"RMT Qty. TO Po")
        {
          ApplicationArea = All;
        }
        field("RMT Make TO PO";"RMT Make TO PO")
        {
          ApplicationArea = All;
        }
        field("RMT Purchase Request";"RMT Purchase Request")
        {
          ApplicationArea = All;
        }
      }
    }
  }
  actions
  {
    area(Processing)
    {
      action(Select)
      {
        ApplicationArea = Planning;
        Caption = 'Select';
        Image = SelectEntries;
        Ellipsis = true;
        Promoted = true;
        PromotedCategory = Process;
        PromotedIsBig = true;

        trigger OnAction()var PurchaselineSelect: Record "Purchase Line";
        begin
          // CurrPage.SetRecord(PurchaselineSelect);
          PurchaselineSelect.reset;
          PurchaselineSelect.SetRange("RMT Purchase Request", true);
          if PurchaselineSelect.Find('-')then PurchaselineSelect.ModifyAll("RMT Select PR to PO", not "RMT Select PR to PO");
        //     PurchaselineSelect.ModifyAll("RMT Select PR to PO", not "RMT Select PR to PO");
        end;
      }
      action(CarryOutActionMessage)
      {
        ApplicationArea = Planning;
        Caption = 'Carry &Out Action Message';
        Ellipsis = true;
        Image = CarryOutActionMessage;
        Promoted = true;
        PromotedCategory = Process;
        PromotedIsBig = true;
        ToolTip = 'Use a batch job to help you create actual supply orders from the order proposals.';

        trigger OnAction()begin
          CarryOutActionMsgReq.Run();
          CurrPage.Update(false);
        end;
      }
    }
  }
  trigger OnOpenPage()var myInt: Integer;
  begin
    EditPRTOPO;
  end;
  local procedure EditPRTOPO()var myInt: Integer;
  begin
    PRTOPO:=false;
  end;
  var CarryOutActionMsgReq: Report "RMT Carry Out Action PR.";
  PRTOPO: Boolean;
}
