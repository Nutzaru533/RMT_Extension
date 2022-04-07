report 50136 "RMT_Summary Rec Detail"
{
  Caption = 'Summary Receiving Supplier Detail';
  UsageCategory = Administration;
  ApplicationArea = All;
  DefaultLayout = RDLC;
  RDLCLayout = 'Report/Layout/SummaryReceivingSuplierDetail2.rdl';

  dataset
  {
  dataitem(PurchRcptHead;
  "Purch. Rcpt. Header")
  {
  RequestFilterFields = "No.", "Expected Receipt Date";
  DataItemTableView = sorting("No.");

  column(Datefilter;
  Datefilter)
  {
  }
  dataitem("Item Ledger Entry";
  "Purch. Rcpt. Line")
  {
  // RequestFilterFields = "No.", "Item Category Code", "Posting Date";
  DataItemTableView = sorting("Document No.");
  DataItemLink = "Document No."=field("No.");

  //CalcFields = "Cost Amount (Actual)", "Cost Amount (Expected)";
  column(Entry_No_;
  EntryNo)
  {
  }
  column(Source_No_;
  "Buy-from Vendor No.")
  {
  }
  column(Source_Type;
  'Purchase')
  {
  }
  column(vendorName;
  vendor.Name)
  {
  }
  column(Item_No_;
  "No.")
  {
  }
  column(Item_Category_Code;
  "Item Category Code")
  {
  }
  column(Description;
  Description)
  {
  }
  column(Unit_of_Measure_Code;
  "Unit of Measure Code")
  {
  }
  column(Cost_Amount__Expected_;
  unitprice)
  {
  }
  column(Quantity;
  Quantity)
  {
  }
  column(InventoryPostingGroup;
  item."Inventory Posting Group")
  {
  }
  column(CalAmount;
  CalAmount)
  {
  }
  column(Picture;
  Compyinformation.Picture)
  {
  }
  column(CompyinformationName;
  Compyinformation.Name)
  {
  }
  column(CompyinformationName2;
  Compyinformation."Name 2")
  {
  }
  column(showDeteil;
  showDeteil)
  {
  }
  column(CalVat;
  CalVat)
  {
  }
  column(CalAmountVat;
  CalAmountVat)
  {
  }
  trigger OnAfterGetRecord()var begin
    Compyinformation.get;
    Compyinformation.CalcFields(Picture);
    vendor.reset;
    if not vendor.get("Buy-from Vendor No.")then vendor.init;
    item.reset;
    if not item.get("No.")then item.Init();
    Clear(CalAmount);
    clear(unitprice);
    Clear(CalVat);
    Clear(CalAmountVat);
    if PurchaseHG.get(PurchaseHG."Document Type"::Order, "Order No.")then begin
      if PurchaseHG."Prices Including VAT" then begin
        // unitprice := "Direct Unit Cost";
        // CalAmount := unitprice * Quantity;
        // if "VAT %" <> 0 then
        //     CalVat := Round(CalAmount * "VAT %" / 107);
        // CalAmount := CalAmount - CalVat;
        // CalAmountVat := CalAmount + CalVat;
        purchaseline.reset;
        purchaseline.SetRange("Document No.", "Order No.");
        purchaseline.SetRange("Line No.", "Order Line No.");
        if purchaseline.Find('-')then begin
          unitprice:="Direct Unit Cost";
          CalAmount:=purchaseline.Amount;
          CalAmountVat:=purchaseline."Amount Including VAT";
          CalVat:=CalAmountVat - CalAmount;
        end;
      end
      else
      begin
        // unitprice := "Direct Unit Cost";
        // CalAmount := unitprice * Quantity;
        // if "VAT %" <> 0 then
        //     CalVat := Round(CalAmount * "VAT %" / 100);
        // CalAmountVat := CalAmount + CalVat;
        purchaseline.reset;
        purchaseline.SetRange("Document No.", "Order No.");
        purchaseline.SetRange("Line No.", "Order Line No.");
        if purchaseline.Find('-')then begin
          unitprice:="Direct Unit Cost";
          CalAmount:=purchaseline.Amount;
          CalAmountVat:=purchaseline."Amount Including VAT";
          CalVat:=CalAmountVat - CalAmount;
        end;
      end;
    end;
    if "Item Category Code" = '' then "Item Category Code":='Expense';
    if item."Inventory Posting Group" = '' then item."Inventory Posting Group":='Expense';
    entryno:=format("Document No.") + format("Line No.");
  end;
  }
  trigger OnAfterGetRecord()var myInt: Integer;
  begin
    Datefilter:=PurchRcptHead.GetFilter("Expected Receipt Date");
  end;
  }
  }
  requestpage
  {
    layout
    {
      area(Content)
      {
        group(GroupName)
        {
          Caption = 'Option';

          field(showDeteil;showDeteil)
          {
            Caption = 'Show Deteil';
            ApplicationArea = All;
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
    trigger OnOpenPage()var myInt: Integer;
    begin
      showDeteil:=true;
    end;
  }
  var vendor: Record Vendor;
  item: Record item;
  Compyinformation: Record "Company Information";
  CalAmount: Decimal;
  showDeteil: Boolean;
  unitprice: Decimal;
  CalAmountVat: Decimal;
  CalVat: Decimal;
  EntryNo: Text[100];
  PurchaseHG: Record "Purchase Header";
  Datefilter: Text[100];
  purchaseline: Record "Purchase Line";
}
