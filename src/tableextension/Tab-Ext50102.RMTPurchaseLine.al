tableextension 50102 "RMTPurchaseLine" extends "Purchase Line"
{
  fields
  {
    modify("No.")
    {
    trigger OnAfterValidate()var XPurchaseRequestLine: Record "Purchase Line";
    begin
      if type = type::item then begin
        if "no." <> '' then begin
          XPurchaseRequestLine.reset;
          XPurchaseRequestLine.SetCurrentKey("RMT Vendor Select Price");
          XPurchaseRequestLine.SetRange("Document Type", XPurchaseRequestLine."Document type"::Quote);
          XPurchaseRequestLine.setrange("RMT Request for Quote", true);
          XPurchaseRequestLine.SetRange("RMT Request Status", XPurchaseRequestLine.Status::Released);
          XPurchaseRequestLine.setrange("RMT Item No.", "No.");
          CalcFields("RMT Document Date");
          XPurchaseRequestLine.CalcFields("RMT Starting Date", "RMT Ending Date");
          XPurchaseRequestLine.SetFilter("RMT Starting Date", '<=%1', "RMT Document Date");
          XPurchaseRequestLine.SetFilter("RMT ending Date", '>=%1', "RMT Document Date");
          if XPurchaseRequestLine.Find('-')then begin
            validate("RMT PO Direct Unit Cost", XPurchaseRequestLine."RMT Vendor Select Price");
            Validate("Direct Unit Cost", XPurchaseRequestLine."RMT Vendor Select Price");
            "RMT Select Vendor No.":=XPurchaseRequestLine."RMT Selected Vendor No.";
            "RMT Get Price Doc No.":=XPurchaseRequestLine."Document No.";
          end;
        end;
      end;
    end;
    }
    modify(Quantity)
    {
    trigger OnAfterValidate()var XPurchaseRequestLine: Record "Purchase Line";
    begin
      if Quantity <> 0 then if type = type::item then begin
          XPurchaseRequestLine.reset;
          XPurchaseRequestLine.SetCurrentKey("RMT Vendor Select Price");
          XPurchaseRequestLine.SetRange("Document Type", XPurchaseRequestLine."Document type"::Quote);
          XPurchaseRequestLine.setrange("RMT Request for Quote", true);
          XPurchaseRequestLine.SetRange("RMT Request Status", XPurchaseRequestLine.Status::Released);
          XPurchaseRequestLine.setrange("RMT Item No.", "No.");
          CalcFields("RMT Document Date");
          XPurchaseRequestLine.CalcFields("RMT Starting Date", "RMT Ending Date");
          XPurchaseRequestLine.SetFilter("RMT Starting Date", '<=%1', "RMT Document Date");
          XPurchaseRequestLine.SetFilter("RMT ending Date", '>=%1', "RMT Document Date");
          if XPurchaseRequestLine.Find('-')then begin
            validate("RMT PO Direct Unit Cost", XPurchaseRequestLine."RMT Vendor Select Price");
            Validate("Direct Unit Cost", XPurchaseRequestLine."RMT Vendor Select Price");
            "RMT Select Vendor No.":=XPurchaseRequestLine."RMT Selected Vendor No.";
            "RMT Get Price Doc No.":=XPurchaseRequestLine."Document No.";
          end;
        end;
    end;
    }
    // Add changes to table fields here
    field(50101;"RMT Purchase Request";Boolean)
    {
      Caption = 'Purchase Request';
      DataClassification = ToBeClassified;
    }
    field(50102;"RMT PO Direct Unit Cost";Decimal)
    {
      Caption = 'PO Direce Unit Cost';
      AutoFormatExpression = "RMT PR Currency Code";
      AutoFormatType = 2;
      CaptionClass = GetCaptionClass(FieldNo("RMT PO Direct Unit Cost"));

      trigger OnValidate()begin
        //Validate("Line Discount %");
        "RMT PO Line Amount":=round("RMT PO Direct Unit Cost" * Quantity);
      end;
    }
    field(50103;"RMT PO Line Amount";Decimal)
    {
      Caption = 'PO Line Amount';
      DataClassification = ToBeClassified;
    }
    field(50104;"RMT Select Vendor No.";code[20])
    {
      Caption = 'Selecet Vendor No.';
      TableRelation = Vendor;
      DataClassification = ToBeClassified;

      trigger OnValidate()var XPurchaseRequestLine: Record "Purchase Line";
      begin
        SuspendStatusCheck(true);
        if("RMT Select Vendor No." <> '') and ("No." <> '')then begin
          XPurchaseRequestLine.reset;
          XPurchaseRequestLine.SetCurrentKey("RMT Vendor Select Price");
          XPurchaseRequestLine.SetRange("Document Type", XPurchaseRequestLine."Document type"::Quote);
          XPurchaseRequestLine.setrange("RMT Request for Quote", true);
          XPurchaseRequestLine.SetRange("RMT Request Status", XPurchaseRequestLine.Status::Released);
          XPurchaseRequestLine.setrange("RMT Item No.", "No.");
          XPurchaseRequestLine.SetRange("RMT Selected Vendor No.", "RMT Select Vendor No.");
          CalcFields("RMT Document Date");
          XPurchaseRequestLine.CalcFields("RMT Starting Date", "RMT Ending Date");
          XPurchaseRequestLine.SetFilter("RMT Starting Date", '<=%1', "RMT Document Date");
          XPurchaseRequestLine.SetFilter("RMT ending Date", '>=%1', "RMT Document Date");
          if XPurchaseRequestLine.Find('-')then begin
            validate("RMT PO Direct Unit Cost", XPurchaseRequestLine."RMT Vendor Select Price");
            Validate("Direct Unit Cost", XPurchaseRequestLine."RMT Vendor Select Price");
            //"RMT Select Vendor No." := XPurchaseRequestLine."RMT Selected Vendor No.";
            "RMT Get Price Doc No.":=XPurchaseRequestLine."Document No.";
          end
          else
          begin
            validate("RMT PO Direct Unit Cost", 0);
            Validate("Direct Unit Cost", 0);
          end;
        end
        else
        begin
          validate("RMT PO Direct Unit Cost", 0);
          Validate("Direct Unit Cost", 0);
        end;
      end;
    }
    field(50105;"RMT Select Vendor Name";Text[100])
    {
      Caption = 'Select Vendor Name';
      FieldClass = FlowField;
      CalcFormula = lookup(vendor.Name where("No."=field("RMT Select Vendor No.")));
      Editable = false;
    //DataClassification = ToBeClassified;
    }
    field(50106;"RMT Select PR to PO";Boolean)
    {
      Caption = 'Select PR to PO';
      DataClassification = ToBeClassified;

      trigger OnValidate()var myInt: Integer;
      begin
        TestField("RMT Select Vendor No.");
        if Quantity <= 0 then Error('Qunatity must be more than 0');
      end;
    }
    field(50107;"RMT PR Currency Code";Code[20])
    {
      Caption = 'PR Currency Code';
      DataClassification = ToBeClassified;
    }
    field(50108;"RMT Qty. Make PO";Decimal)
    {
      Caption = 'Qty. Make PO';
    //DataClassification = ToBeClassified;
    }
    field(50109;"RMT PR Status";Enum "Purchase Document Status")
    {
      Caption = 'PR Status';
      FieldClass = FlowField;
      CalcFormula = lookup("Purchase Header".Status where("Document Type"=field("Document Type"), "No."=field("Document No.")));
      Editable = false;
    }
    field(50110;"RMT Purchase Request No.";Code[20])
    {
      Caption = 'Purchase Request No.';
      DataClassification = ToBeClassified;
    }
    field(50111;"RMT Make TO PO";Boolean)
    {
      Caption = 'Make TO PO';
      DataClassification = ToBeClassified;
    }
    field(50112;"RMT Qty. TO Po";Decimal)
    {
      Caption = 'Qty. TO Po';
      FieldClass = FlowField;
      CalcFormula = sum("Purchase Line".Quantity where("Document Type"=const(Order), "RMT Purchase Request No."=field("Document No."), "RMT Purchase Request Line"=field("Line No.")));
    }
    field(50113;"RMT Purchase Request Line";Integer)
    {
      Caption = 'Purchase Request Line';
      DataClassification = ToBeClassified;
    }
    field(50114;"RMT Item No.";Code[20])
    {
      Caption = 'Item No.';
      TableRelation = Item;
      DataClassification = ToBeClassified;

      trigger OnValidate()var item: Record item;
      PurchaseHeader: Record "Purchase Header";
      PurchaseSetup: Record "Purchases & Payables Setup";
      begin
        "RMT Request for Quote":=true;
        if "RMT Item No." <> '' then begin
          PurchaseSetup.get;
          "Location Code":=PurchaseSetup."RMT Request Location";
          Type:=Type::Item;
          "No.":="RMT Item No.";
          if item.get("RMT Item No.")then begin
            Description:=item.Description;
            "Description 2":=item."Description 2";
            "RMT Unit of Measure":=item."Base Unit of Measure";
          end;
          if PurchaseHeader.get("Document Type", "Document No.")then begin
            "RMT Vendor No.1":=PurchaseHeader."RMT Vendor No. 1";
            "RMT Vendor No.2":=PurchaseHeader."RMT Vendor No. 2";
            "RMT Vendor No.3":=PurchaseHeader."RMT Vendor No. 3";
            "RMT Vendor No.4":=PurchaseHeader."RMT Vendor No. 4";
            "RMT Vendor No.5":=PurchaseHeader."RMT Vendor No. 5";
          end;
        end;
      end;
    }
    field(50115;"RMT Quantity";Decimal)
    {
      Caption = 'Quantity';
      DataClassification = ToBeClassified;

      trigger OnValidate()var myInt: Integer;
      begin
        validate(Quantity, "RMT Quantity");
      end;
    }
    field(50116;"RMT Unit of Measure";Code[20])
    {
      Caption = 'Unti of Measure';
      DataClassification = ToBeClassified;
      TableRelation = "Unit of Measure";
    }
    field(50117;"RMT Vendor No.1";Code[20])
    {
      Caption = 'Vendor No.1';
      DataClassification = ToBeClassified;
    }
    field(50118;"RMT Vendor No.2";Code[20])
    {
      Caption = 'Vendor No.2';
      DataClassification = ToBeClassified;
    }
    field(50119;"RMT Vendor No.3";Code[20])
    {
      Caption = 'Vendor No.3';
      DataClassification = ToBeClassified;
    }
    field(50120;"RMT Vendor No.4";Code[20])
    {
      Caption = 'Vendor No.4';
      DataClassification = ToBeClassified;
    }
    field(50121;"RMT Vendor No.5";Code[20])
    {
      Caption = 'Vendor No.5';
      DataClassification = ToBeClassified;
    }
    field(50122;"RMT Vendor Price 1";Decimal)
    {
      Caption = 'Vendor Price 1';
      DataClassification = ToBeClassified;
    }
    field(50123;"RMT Vendor Price 2";Decimal)
    {
      Caption = 'Vendor Price 2';
      DataClassification = ToBeClassified;
    }
    field(50124;"RMT Vendor Price 3";Decimal)
    {
      Caption = 'Vendor Price 3';
      DataClassification = ToBeClassified;
    }
    field(50125;"RMT Vendor Price 4";Decimal)
    {
      Caption = 'Vendor Price 4';
      DataClassification = ToBeClassified;
    }
    field(50126;"RMT Vendor Price 5";Decimal)
    {
      Caption = 'Vendor Price 5';
      DataClassification = ToBeClassified;
    }
    field(50127;"RMT Selected Vendor No.";Code[20])
    {
      Caption = 'Selected Vendor No.';
      TableRelation = Vendor;
      DataClassification = ToBeClassified;

      trigger OnValidate()var y: Integer;
      Temppurchaseprice: Record "Purchase Price" temporary;
      begin
        if "RMT Selected Vendor No." <> '' then begin
          Temppurchaseprice.Deleteall;
          for y:=1 to 5 do begin
            Temppurchaseprice.init;
            if y = 1 then begin
              if "RMT Vendor No.1" <> '' then begin
                Temppurchaseprice."Vendor No.":="RMT Vendor No.1";
                Temppurchaseprice."Direct Unit Cost":="RMT Vendor Price 1";
                Temppurchaseprice.Insert();
              end;
            end;
            if y = 2 then begin
              if "RMT Vendor No.2" <> '' then begin
                Temppurchaseprice."Vendor No.":="RMT Vendor No.2";
                Temppurchaseprice."Direct Unit Cost":="RMT Vendor Price 2";
                Temppurchaseprice.Insert();
              end;
            end;
            if y = 3 then begin
              if "RMT Vendor No.3" <> '' then begin
                Temppurchaseprice."Vendor No.":="RMT Vendor No.3";
                Temppurchaseprice."Direct Unit Cost":="RMT Vendor Price 3";
                Temppurchaseprice.Insert();
              end;
            end;
            if y = 4 then begin
              if "RMT Vendor No.4" <> '' then begin
                Temppurchaseprice."Vendor No.":="RMT Vendor No.4";
                Temppurchaseprice."Direct Unit Cost":="RMT Vendor Price 4";
                Temppurchaseprice.Insert();
              end;
            end;
            if y = 5 then begin
              if "RMT Vendor No.5" <> '' then begin
                Temppurchaseprice."Vendor No.":="RMT Vendor No.5";
                Temppurchaseprice."Direct Unit Cost":="RMT Vendor Price 5";
                Temppurchaseprice.Insert();
              end;
            end;
          //Temppurchaseprice.Insert();
          end;
          Temppurchaseprice.SetCurrentKey("Direct Unit Cost");
          Temppurchaseprice.SetRange("Vendor No.", "RMT Selected Vendor No.");
          if Temppurchaseprice.Find('-')then begin
            "RMT Vendor Select Price":=Temppurchaseprice."Direct Unit Cost";
          end;
        end
        else
          "RMT Vendor Select Price":=0;
      end;
    }
    field(50128;"RMT Starting Date";Date)
    {
      Caption = 'Starting Date';
      FieldClass = FlowField;
      CalcFormula = lookup("Purchase Header"."RMT Starting Date" where("Document Type"=field("Document Type"), "No."=field("Document No.")));
    }
    field(50129;"RMT Ending Date";Date)
    {
      Caption = 'Ending Date';
      FieldClass = FlowField;
      CalcFormula = lookup("Purchase Header"."RMT Ending Date" where("Document Type"=field("Document Type"), "No."=field("Document No.")));
    }
    field(50130;"RMT Request Status";Enum "Purchase Document Status")
    {
      Caption = 'Request Status';
      FieldClass = FlowField;
      CalcFormula = lookup("Purchase Header".Status where("Document Type"=field("Document Type"), "No."=field("Document No.")));
    }
    field(50131;"RMT Request for Quote";Boolean)
    {
      Caption = 'Request for Quote';
      DataClassification = ToBeClassified;
    }
    field(50132;"RMT Vendor Select Price";Decimal)
    {
      Caption = 'Vendor Select Price';
      DataClassification = ToBeClassified;
    }
    field(50133;"RMT Document Date";Date)
    {
      Caption = 'Document Date';
      FieldClass = FlowField;
      CalcFormula = lookup("Purchase Header"."Document Date" where("Document Type"=field("Document Type"), "No."=field("Document No.")));
    //DataClassification = ToBeClassified;
    }
    field(50134;"RMT Get Price Doc No.";Code[50])
    {
      Caption = 'Document No. Price';
      DataClassification = ToBeClassified;
    }
    field(50135;"RMT External Doc No.";Code[20])
    {
      Caption = 'External Document No.';
      DataClassification = ToBeClassified;
    }
  }
  keys
  {
    key(PRTOPO;"RMT Select Vendor No.") //secondary key
    {
    }
  }
  procedure SetupPurchaseRequest()var PurchHeader: Record "Purchase Header";
  begin
    if "Document No." <> '' then begin
      if not PurchHeader.Get("Document Type", "Document No.")then exit;
      "RMT Purchase Request":=true;
    end;
  end;
  procedure SetupPurchaseRequest2()var PurchHeader: Record "Purchase Header";
  begin
    if "Document No." <> '' then begin
      if not PurchHeader.Get("Document Type", "Document No.")then exit;
      "RMT Request for Quote":=true;
    end;
  end;
  procedure GetBestPrice(xPurchaseLine: Record "Purchase Line")var y: Integer;
  Temppurchaseprice: Record "Purchase Price" temporary;
  LoopPurchaseLine: Record "Purchase Line";
  begin
    LoopPurchaseLine.reset;
    LoopPurchaseLine.SetRange("Document Type", xPurchaseLine."Document Type");
    LoopPurchaseLine.SetRange("Document No.", xPurchaseLine."Document No.");
    if LoopPurchaseLine.find('-')then begin
      repeat Temppurchaseprice.Deleteall;
        for y:=1 to 5 do begin
          Temppurchaseprice.init;
          if y = 1 then begin
            if(LoopPurchaseLine."RMT Vendor No.1" <> '') and (LoopPurchaseLine."RMT Vendor Price 1" <> 0)then begin
              Temppurchaseprice."Vendor No.":=LoopPurchaseLine."RMT Vendor No.1";
              Temppurchaseprice."Direct Unit Cost":=LoopPurchaseLine."RMT Vendor Price 1";
              Temppurchaseprice.Insert();
            end;
          end;
          if y = 2 then begin
            if(LoopPurchaseLine."RMT Vendor No.2" <> '') and (LoopPurchaseLine."RMT Vendor Price 2" <> 0)then begin
              Temppurchaseprice."Vendor No.":=LoopPurchaseLine."RMT Vendor No.2";
              Temppurchaseprice."Direct Unit Cost":=LoopPurchaseLine."RMT Vendor Price 2";
              Temppurchaseprice.Insert();
            end;
          end;
          if y = 3 then begin
            if(LoopPurchaseLine."RMT Vendor No.3" <> '') and (LoopPurchaseLine."RMT Vendor Price 3" <> 0)then begin
              Temppurchaseprice."Vendor No.":=LoopPurchaseLine."RMT Vendor No.3";
              Temppurchaseprice."Direct Unit Cost":=LoopPurchaseLine."RMT Vendor Price 3";
              Temppurchaseprice.Insert();
            end;
          end;
          if y = 4 then begin
            if(LoopPurchaseLine."RMT Vendor No.4" <> '') and (LoopPurchaseLine."RMT Vendor Price 4" <> 0)then begin
              Temppurchaseprice."Vendor No.":=LoopPurchaseLine."RMT Vendor No.4";
              Temppurchaseprice."Direct Unit Cost":=LoopPurchaseLine."RMT Vendor Price 4";
              Temppurchaseprice.Insert();
            end;
          end;
          if y = 5 then begin
            if(LoopPurchaseLine."RMT Vendor No.5" <> '') and (LoopPurchaseLine."RMT Vendor Price 5" <> 0)then begin
              Temppurchaseprice."Vendor No.":=LoopPurchaseLine."RMT Vendor No.5";
              Temppurchaseprice."Direct Unit Cost":=LoopPurchaseLine."RMT Vendor Price 5";
              Temppurchaseprice.Insert();
            end;
          end;
        //Temppurchaseprice.Insert();
        end;
        Temppurchaseprice.SetCurrentKey("Direct Unit Cost");
        //Temppurchaseprice.SetRange("Vendor No.", "RMT Selected Vendor No.");
        //Temppurchaseprice.SetFilter("Direct Unit Cost", '<>%1', 0);
        if Temppurchaseprice.Find('-')then begin
          LoopPurchaseLine."RMT Selected Vendor No.":=Temppurchaseprice."Vendor No.";
          LoopPurchaseLine."RMT Vendor Select Price":=Temppurchaseprice."Direct Unit Cost";
          LoopPurchaseLine.Modify();
          Temppurchaseprice.Reset();
          Temppurchaseprice.SetFilter("Vendor No.", '<>%1', '');
          if Temppurchaseprice.find('-')then Temppurchaseprice.Deleteall;
        end;
      until LoopPurchaseLine.Next() = 0;
    end;
  end;
}
