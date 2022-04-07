tableextension 50101 "RMTPurchaseHeader" extends "Purchase Header"
{
  fields
  {
    // Add changes to table fields here
    modify("Buy-from Vendor No.")
    {
    trigger OnBeforeValidate()var XpurchaseH: Record "Purchase Header";
    begin
      XpurchaseH:=rec;
    end;
    trigger OnAfterValidate()var myInt: Integer;
    begin
    end;
    }
    field(50101;"RMT Purchase Request";Boolean)
    {
      Caption = 'Purchase Request';
      DataClassification = ToBeClassified;
    }
    field(50102;"RMT Request for Quote";Boolean)
    {
      Caption = 'Request for Quote';
      DataClassification = ToBeClassified;
    }
    field(50103;"RMT Vendor No. 1";Code[20])
    {
      Caption = 'Vendor No. 1';
      TableRelation = Vendor;
      DataClassification = ToBeClassified;

      trigger OnValidate()var myInt: Integer;
      begin
        if vendor.get("RMT Vendor No. 1")then begin
          "RMT AVL Vendor 1":=vendor."RMT VAL";
          "RMT Vendor Name 1":=vendor.Name;
        end
        else
        begin
          "RMT AVL Vendor 1":=false;
          "RMT Vendor Name 1":='';
        end;
      end;
    }
    field(50104;"RMT Vendor Name 1";Text[100])
    {
      Editable = false;
      Caption = 'Vendor Name 1';
      //FieldClass = FlowField;
      //CalcFormula = lookup(vendor.Name where("No." = field("RMT Vendor No. 1")));
      DataClassification = ToBeClassified;
    }
    field(50105;"RMT Vendor No. 2";Code[20])
    {
      Caption = 'Vendor No. 2';
      TableRelation = Vendor;
      DataClassification = ToBeClassified;

      trigger OnValidate()var myInt: Integer;
      begin
        if vendor.get("RMT Vendor No. 2")then begin
          "RMT AVL Vendor 2":=vendor."RMT VAL";
          "RMT Vendor Name 2":=vendor.Name;
        end
        else
        begin
          "RMT AVL Vendor 2":=false;
          "RMT Vendor Name 2":='';
        end;
      end;
    }
    field(50106;"RMT Vendor Name 2";Text[100])
    {
      Editable = false;
      Caption = 'Vendor Name 2';
      //FieldClass = FlowField;
      //CalcFormula = lookup(vendor.Name where("No." = field("RMT Vendor No. 2")));
      DataClassification = ToBeClassified;
    }
    field(50107;"RMT Vendor No. 3";Code[20])
    {
      Caption = 'Vendor No. 3';
      TableRelation = Vendor;
      DataClassification = ToBeClassified;

      trigger OnValidate()var myInt: Integer;
      begin
        if vendor.get("RMT Vendor No. 3")then begin
          "RMT AVL Vendor 3":=vendor."RMT VAL";
          "RMT Vendor Name 3":=vendor.Name;
        end
        else
        begin
          "RMT AVL Vendor 3":=false;
          "RMT Vendor Name 3":='';
        end;
      end;
    }
    field(50108;"RMT Vendor Name 3";Text[100])
    {
      Editable = false;
      Caption = 'Vendor Name 3';
      //FieldClass = FlowField;
      //CalcFormula = lookup(vendor.Name where("No." = field("RMT Vendor No. 3")));
      DataClassification = ToBeClassified;
    }
    field(50109;"RMT Vendor No. 4";Code[20])
    {
      Caption = 'Vendor No. 4';
      TableRelation = Vendor;
      DataClassification = ToBeClassified;

      trigger OnValidate()var myInt: Integer;
      begin
        if vendor.get("RMT Vendor No. 4")then begin
          "RMT AVL Vendor 4":=vendor."RMT VAL";
          "RMT Vendor Name 4":=vendor.Name;
        end
        else
        begin
          "RMT AVL Vendor 4":=false;
          "RMT Vendor Name 4":='';
        end;
      end;
    }
    field(50110;"RMT Vendor Name 4";Text[100])
    {
      Editable = false;
      Caption = 'Vendor Name 4';
      //FieldClass = FlowField;
      //CalcFormula = lookup(vendor.Name where("No." = field("RMT Vendor No. 4")));
      DataClassification = ToBeClassified;
    }
    field(50111;"RMT Vendor No. 5";Code[20])
    {
      Caption = 'Vendor No. 5';
      TableRelation = Vendor;
      DataClassification = ToBeClassified;

      trigger OnValidate()var myInt: Integer;
      begin
        if vendor.get("RMT Vendor No. 5")then begin
          "RMT AVL Vendor 5":=vendor."RMT VAL";
          "RMT Vendor Name 5":=vendor.Name;
        end
        else
        begin
          "RMT AVL Vendor 5":=false;
          "RMT Vendor Name 5":='';
        end;
      end;
    }
    field(50112;"RMT Vendor Name 5";Text[100])
    {
      Editable = false;
      Caption = 'Vendor Name 5';
      //FieldClass = FlowField;
      //CalcFormula = lookup(vendor.Name where("No." = field("RMT Vendor No. 5")));
      DataClassification = ToBeClassified;
    }
    field(50113;"RMT AVL Vendor 1";Boolean)
    {
      Caption = 'AVL Vendor 1';
      DataClassification = ToBeClassified;
    }
    field(50114;"RMT AVL Vendor 2";Boolean)
    {
      Caption = 'AVL Vendor 2';
      DataClassification = ToBeClassified;
    }
    field(50115;"RMT AVL Vendor 3";Boolean)
    {
      Caption = 'AVL Vendor 3';
      DataClassification = ToBeClassified;
    }
    field(50116;"RMT AVL Vendor 4";Boolean)
    {
      Caption = 'AVL Vendor 4';
      DataClassification = ToBeClassified;
    }
    field(50117;"RMT AVL Vendor 5";Boolean)
    {
      Caption = 'AVL Vendor 5';
      DataClassification = ToBeClassified;
    }
    field(50118;"RMT Remark";Text[250])
    {
      Caption = 'Remark';
      DataClassification = ToBeClassified;
    }
    field(50119;"RMT Status";enum "Purchase Document Status")
    {
      Caption = 'Status';
      DataClassification = ToBeClassified;
    }
    field(50120;"RMT Starting Date";Date)
    {
      Caption = 'Starting Date';
      DataClassification = ToBeClassified;
    }
    field(50121;"RMT Ending Date";Date)
    {
      Caption = 'Ending Date';
      DataClassification = ToBeClassified;
    }
    modify("Location Code")
    {
    trigger OnAfterValidate()var RomanticFunction: Codeunit "Romantic Function";
    UserLogin: Record "User Password Login";
    begin
      if xRec."Location Code" <> "Location Code" then begin
        UserLogin.reset;
        UserLogin.SetRange("User Name", RomanticFunction.GetLoginInfo());
        UserLogin.SetFilter(Department, '<>%1', '');
        if UserLogin.FindFirst()then Validate("Shortcut Dimension 1 Code", UserLogin.Department);
      //    Validate("Shortcut Dimension 1 Code", UserLogin.Department);
      end;
    end;
    }
  }
  procedure AssistEditRequest(OldPurchHeader: Record "Purchase Header"): Boolean var IsHandled: Boolean;
  UserLogin: Record "User Password Login";
  Usertransection: Record "User Transection";
  Activesession: Record "Active Session";
  RomanticFunction: Codeunit "Romantic Function";
  PurchSetup: Record "Purchases & Payables Setup";
  begin
    IsHandled:=false;
    if IsHandled then exit;
    GetPurchSetup.Get();
    GetPurchSetup.TestField("RMT Requisition Nos.");
    TestNoSeries();
    if RomanticFunction.SelectSeries(GetPurchSetup."RMT Requisition Nos.", OldPurchHeader."No. Series", "No. Series")then begin
      TestNoSeries();
      RomanticFunction.SetSeries("No.");
      //NoSeriesMgt.SetSeries("No.");
      //Purchase Request
      "RMT Purchase Request":=true;
      Validate("Buy-from Vendor No.", GetPurchSetup."RMT PR Dummy Vendor");
      //Purchase Request
      exit(true);
    end;
  // GetPurchSetup.get;
  // GetPurchSetup.TestField("RMT Requisition Nos.");
  // TestNoSeries();
  // if NoSeriesMgt.SelectSeries(GetPurchSetup."RMT Requisition Nos.", OldPurchHeader."No. Series", "No. Series") then begin
  //     TestNoSeries();
  //     //Usertransection."Transection User"
  //     //if not UserLogin.get(UserId)
  //     NoSeriesMgt.SetSeries("No.");
  //     //Purchase Request
  //     "RMT Purchase Request" := true;
  //     Validate("Buy-from Vendor No.", GetPurchSetup."RMT PR Dummy Vendor");
  //     //Purchase Request
  //     exit(true);
  // end;
  end;
  trigger OnDelete()var myInt: Integer;
  purchaseH: Record "Purchase Header";
  begin
    purchaseH.reset;
    purchaseH.SetRange("Document Type", "Document Type"::Quote);
    purchaseH.SetRange("RMT Request for Quote", true);
    purchaseH.SetRange("No.", rec."No.");
    if purchaseH.Find('-')then begin
      if purchaseH.Status = purchaseH.Status::Released then Error('You can not delete Released Document');
    end;
  end;
  procedure AssistEditRequest2(OldPurchHeader: Record "Purchase Header"): Boolean var IsHandled: Boolean;
  UserLogin: Record "User Password Login";
  Usertransection: Record "User Transection";
  Activesession: Record "Active Session";
  RomanticFunction: Codeunit "Romantic Function";
  PurchSetup: Record "Purchases & Payables Setup";
  begin
    IsHandled:=false;
    if IsHandled then exit;
    GetPurchSetup.get;
    GetPurchSetup.TestField("RMT Request for quote Nos.");
    TestNoSeries();
    if RomanticFunction.SelectSeries(GetPurchSetup."RMT Request for quote Nos.", OldPurchHeader."No. Series", "No. Series")then begin
      TestNoSeries();
      RomanticFunction.SetSeries("No.");
      //Purchase Request
      "RMT Request for Quote":=true;
      Validate("Buy-from Vendor No.", GetPurchSetup."RMT Vendor For RFQ");
      // if xRec."Buy-from Vendor No." <> "Buy-from Vendor No." then begin
      //     UserLogin.reset;
      //     UserLogin.SetRange("User Name", "Transection By");
      //     UserLogin.SetFilter(Department, '<>%1', '');
      //     if UserLogin.FindFirst() then
      //         Validate("Shortcut Dimension 1 Code", UserLogin.Department);
      // end;
      //Purchase Request
      exit(true);
    end;
  // GetPurchSetup.get;
  // GetPurchSetup.TestField("RMT Request for quote Nos.");
  // TestNoSeries();
  // if NoSeriesMgt.SelectSeries(GetPurchSetup."RMT Request for quote Nos.", OldPurchHeader."No. Series", "No. Series") then begin
  //     TestNoSeries();
  //     NoSeriesMgt.SetSeries("No.");
  //     //Purchase Request
  //     "RMT Request for Quote" := true;
  //     Validate("Buy-from Vendor No.", GetPurchSetup."RMT Vendor For RFQ");
  //     //Purchase Request
  //     exit(true);
  // end;
  end;
  trigger OnInsert()var RomanticFunction: Codeunit "Romantic Function";
  begin
    "Transection By":=RomanticFunction.GetLoginInfo();
    "Transection DateTime":=CurrentDateTime;
  end;
  trigger OnAfterModify()var RomanticFunction: Codeunit "Romantic Function";
  begin
    "Transection By":=RomanticFunction.GetLoginInfo();
    "Transection DateTime":=CurrentDateTime;
  end;
  var GetPurchSetup: Record "Purchases & Payables Setup";
  NoSeriesMgt: Codeunit NoSeriesManagement;
  vendor: Record Vendor;
}
