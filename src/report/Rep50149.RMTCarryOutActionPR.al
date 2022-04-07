report 50149 "RMT Carry Out Action PR."
{
  Caption = 'Carry Out Action Msg. - PR';
  ProcessingOnly = true;

  dataset
  {
  dataitem(PurchaseLine;
  "Purchase Line")
  {
  DataItemTableView = SORTING("RMT Select Vendor No.")WHERE("RMT Select Vendor No."=filter(<>''), "RMT Qty. Make PO"=filter(<>0), "RMT Select PR to PO"=const(true), "Document Type"=CONST(Quote), "RMT Purchase Request"=filter(true), Type=filter(<>''));

  trigger OnAfterGetRecord()var myInt: Integer;
  begin
    if OldVendorNo <> "RMT Select Vendor No." then begin
      //Create Header
      NewPurchaseHeader.init;
      NewPurchaseHeader."Document Type":=NewPurchaseHeader."Document Type"::Order;
      NewPurchaseHeader."No. Series":=NewNoSerial;
      NewPurchaseHeader."No.":=NoSeriesMGT.GetNextNo(NewNoSerial, WorkDate(), true);
      //NewPurchaseHeader.InitInsert();
      NewPurchaseHeader.InitRecord();
      NewPurchaseHeader.Validate("Buy-from Vendor No.", PurchaseLine."RMT Select Vendor No.");
      NewPurchaseHeader.Insert();
      NewPurchaseOrderNo:=NewPurchaseHeader."No.";
      //Create Header
      //Create Line
      NewPurchaseLine.init;
      NewPurchaseLine."Document Type":=NewPurchaseLine."Document Type"::Order;
      NewPurchaseLine."Document No.":=NewPurchaseOrderNo;
      NewLineNo+=10000;
      NewPurchaseLine.Type:=Type;
      NewPurchaseLine.Validate("No.", "No.");
      NewPurchaseLine.Description:=Description;
      NewPurchaseLine."Description 2":="Description 2";
      NewPurchaseLine."Line No.":=NewLineNo;
      NewPurchaseLine."RMT Purchase Request Line":="Line No.";
      NewPurchaseLine.Validate("Location Code", "Location Code");
      NewPurchaseLine.Validate(Quantity, "RMT Qty. Make PO");
      NewPurchaseLine.Validate("Unit of Measure Code", "Unit of Measure Code");
      if "RMT PO Direct Unit Cost" = 0 then "RMT PO Direct Unit Cost":="Direct Unit Cost";
      NewPurchaseLine.Validate("Direct Unit Cost", "RMT PO Direct Unit Cost");
      NewPurchaseLine."RMT Purchase Request No.":="Document No.";
      NewPurchaseLine.Insert();
      //PurchaseLine.CalcFields("RMT Qty. TO Po");
      //NewPurchaseLine.Validate();
      //Create Line
      //check qty in pr 
      CalcFields("RMT Qty. TO Po");
      if "RMT Qty. TO Po" = Quantity then begin
        "RMT Make TO PO":=true;
      end;
      "RMT Qty. Make PO":=0;
      Modify();
      Message('Make To PO No. %1', NewPurchaseOrderNo);
    //check qty in pr
    end
    else
    begin
      //Create Line
      NewPurchaseLine.init;
      NewPurchaseLine."Document Type":=NewPurchaseLine."Document Type"::Order;
      NewPurchaseLine."Document No.":=NewPurchaseOrderNo;
      NewLineNo+=10000;
      NewPurchaseLine.Type:=Type;
      NewPurchaseLine.Validate("No.", "No.");
      NewPurchaseLine."Line No.":=NewLineNo;
      NewPurchaseLine.Description:=Description;
      NewPurchaseLine."Description 2":="Description 2";
      NewPurchaseLine."RMT Purchase Request Line":="Line No.";
      NewPurchaseLine.Validate("Location Code", "Location Code");
      NewPurchaseLine.Validate(Quantity, "RMT Qty. Make PO");
      NewPurchaseLine.Validate("Unit of Measure Code", "Unit of Measure Code");
      if "RMT PO Direct Unit Cost" = 0 then "RMT PO Direct Unit Cost":="Direct Unit Cost";
      NewPurchaseLine.Validate("Direct Unit Cost", "RMT PO Direct Unit Cost");
      NewPurchaseLine."RMT Purchase Request No.":="Document No.";
      NewPurchaseLine.Insert();
      //PurchaseLine.CalcFields("RMT Qty. TO Po");
      //NewPurchaseLine.Validate();
      //Create Line
      //check qty in pr 
      CalcFields("RMT Qty. TO Po");
      if "RMT Qty. TO Po" = Quantity then begin
        "RMT Make TO PO":=true;
      end;
      "RMT Qty. Make PO":=0;
      Modify();
    end;
    CalcFields("RMT Qty. TO Po");
    if "RMT Qty. TO Po" = Quantity then begin
      "RMT Make TO PO":=true;
    end;
    "RMT Qty. Make PO":=0;
    Modify();
    OldVendorNo:="RMT Select Vendor No.";
  end;
  }
  }
  requestpage
  {
    SaveValues = true;

    layout
    {
      area(Content)
      {
        group(Option)
        {
          Caption = 'Option';

          field(NewNoSerial;NewNoSerial)
          {
            Caption = 'PO Nos.';
            ApplicationArea = Planning;

            trigger OnLookup(VAR Text: Text): Boolean var noserialline: Record "No. Series Line";
            NoSeriesMgt: Codeunit NoSeriesManagement;
            begin
              FilterSeries;
              if PAGE.RunModal(0, NoSeries) = ACTION::LookupOK then begin
                NewNoSerial:=NoSeries.Code;
              end;
            end;
          }
        }
      }
    }
    actions
    {
      area(processing)
      {
        action(ActionName)
        {
          ApplicationArea = All;
        }
      }
    }
  }
  var NewNoSerial: code[20];
  NoSeries: Record "No. Series";
  purchasesetup: Record "Purchases & Payables Setup";
  OldVendorNo: code[20];
  NewPurchaseLine: Record "Purchase Line";
  NewPurchaseHeader: Record "Purchase Header";
  NewPurchaseOrderNo: code[20];
  NoSeriesMGT: Codeunit NoSeriesManagement;
  NewLineNo: Integer;
  local procedure FilterSeries()var NoSeriesRelationship: Record "No. Series Relationship";
  begin
    purchasesetup.get;
    purchasesetup.TestField("Order Nos.");
    NoSeries.Reset();
    NoSeriesRelationship.SetRange(Code, purchasesetup."Order Nos.");
    if NoSeriesRelationship.FindSet then repeat NoSeries.Code:=NoSeriesRelationship."Series Code";
        NoSeries.Mark:=true;
      until NoSeriesRelationship.Next = 0;
    if NoSeries.Get(purchasesetup."Order Nos.")then NoSeries.Mark:=true;
    NoSeries.MarkedOnly:=true;
  end;
}
