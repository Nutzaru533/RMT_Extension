report 50142 "RMT Bin Card"
{
  Caption = 'Bin Card';
  UsageCategory = Administration;
  ApplicationArea = All;
  DefaultLayout = RDLC;
  RDLCLayout = 'Report/Layout/BinCard.rdl';

  dataset
  {
  dataitem(item;
  item)
  {
  RequestFilterFields = "No.", "Location Filter";
  CalcFields = Inventory;

  column(Item_No_;
  "No.")
  {
  }
  column(ItemDescription;
  Description)
  {
  }
  column(Inventory;
  Inventory)
  {
  }
  column(StartingInvoicedValue;
  StartingInvoicedValue)
  {
  }
  column(StartingInvoicedQty;
  StartingInvoicedQty)
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
  column(AvgStartprice;
  AvgStartprice)
  {
  }
  column(StartDate;
  StartDate)
  {
  }
  column(EndDate;
  EndDate)
  {
  }
  dataitem("Item Ledger Entry";
  "Item Ledger Entry")
  {
  DataItemLinkReference = item;
  DataItemLink = "item No."=field("No.");
  //RequestFilterFields = "Item No.", "Item Category Code", "Posting Date";
  DataItemTableView = sorting("Entry No."); //WHERE("Entry Type" = const("Negative Adjmt."));
  CalcFields = "Cost Amount (Actual)", "Cost Amount (Expected)";

  column(Source_No_;
  "Source No.")
  {
  }
  column(Source_Type;
  "Source Type")
  {
  }
  column(vendorName;
  vendor.Name)
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
  item."Base Unit of Measure")
  {
  }
  column(Amount;
  Amount)
  {
  }
  column(Quantity;
  Quantity)
  {
  }
  column(Quantity2;
  Quantity2)
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
  column(showDeteil;
  showDeteil)
  {
  }
  column(Location_Code;
  "Location Code")
  {
  }
  column(Posting_Date;
  "Posting Date")
  {
  }
  column(locationName;
  location.Name)
  {
  }
  column(Document_No_;
  documentNo)
  {
  }
  column(Entry_No_;
  "Entry No.")
  {
  }
  column(TypeTxt;
  TypeTxt)
  {
  }
  column(avgamount;
  avgamount)
  {
  }
  column(PurchasePrice;
  PurchasePrice)
  {
  }
  trigger OnPreDataItem()var myInt: Integer;
  begin
    if StartDate <> 0D then SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
    if item.GetFilter("Location Filter") <> '' then SetFilter("Location Code", item.GetFilter("Location Filter"));
  end;
  trigger OnAfterGetRecord()var PurchRecLine: Record "Purch. Rcpt. Line";
  PurchRecHeader: Record "Purch. Rcpt. Header";
  begin
    PurchasePrice:=0;
    Quantity2:=0;
    avgamount:=0;
    if "Qty. per Unit of Measure" <> 1 then Quantity2:=Quantity / "Qty. per Unit of Measure" // add code
    else
      Quantity2:=Quantity;
    vendor.reset;
    if not vendor.get("Source No.")then vendor.init;
    Clear(CalAmount);
    if "Cost Amount (Expected)" <> 0 then CalAmount:=abs("Cost Amount (Expected)")
    else
      CalAmount:=abs("Cost Amount (Actual)");
    if Quantity < 0 then CalAmount:=CalAmount * -1;
    //add
    CalAmount:=CalAmount / Quantity;
    //add
    CalAmount2:=Quantity * CalAmount;
    if Quantity <> 0 then avgamount:=CalAmount2 / Quantity;
    if not location.get("Location Code")then location.init;
    if Quantity > 0 then TypeTxt:='Iss.In'
    else
      TypeTxt:='Iss.Out';
    PurchRecHeader.reset;
    if PurchRecHeader.get("Document No.")then documentNo:=PurchRecHeader."Order No."
    else
      documentNo:="Document No.";
    //documentNo
    //Amount := Quantity * CalAmount;
    PurchasePrice:=Quantity2 * CalAmount;
    Amount:=Amount + CalAmount2;
  end;
  }
  trigger OnAfterGetRecord()var SkipItem: Boolean;
  IsHandled: Boolean;
  begin
    Compyinformation.get;
    Compyinformation.CalcFields(Picture);
    SkipItem:=false;
    if SkipItem then CurrReport.Skip();
    CalcFields("Assembly BOM");
    if EndDate = 0D then EndDate:=DMY2Date(31, 12, 9999);
    Amount:=0;
    StartingInvoicedValue:=0;
    StartingExpectedValue:=0;
    StartingInvoicedQty:=0;
    StartingExpectedQty:=0;
    IncreaseInvoicedValue:=0;
    IncreaseExpectedValue:=0;
    IncreaseInvoicedQty:=0;
    IncreaseExpectedQty:=0;
    DecreaseInvoicedValue:=0;
    DecreaseExpectedValue:=0;
    DecreaseInvoicedQty:=0;
    DecreaseExpectedQty:=0;
    InvCostPostedToGL:=0;
    CostPostedToGL:=0;
    ExpCostPostedToGL:=0;
    IsEmptyLine:=true;
    ValueEntry.Reset();
    ValueEntry.SetRange("Item No.", "No.");
    ValueEntry.SetFilter("Variant Code", GetFilter("Variant Filter"));
    ValueEntry.SetFilter("Location Code", GetFilter("Location Filter"));
    ValueEntry.SetFilter("Global Dimension 1 Code", GetFilter("Global Dimension 1 Filter"));
    ValueEntry.SetFilter("Global Dimension 2 Code", GetFilter("Global Dimension 2 Filter"));
    if StartDate > 0D then begin
      ValueEntry.SetRange("Posting Date", 0D, CalcDate('<-1D>', StartDate));
      ValueEntry.CalcSums("Item Ledger Entry Quantity", "Cost Amount (Actual)", "Cost Amount (Expected)", "Invoiced Quantity");
      AssignAmounts(ValueEntry, StartingInvoicedValue, StartingInvoicedQty, StartingExpectedValue, StartingExpectedQty, 1);
      IsEmptyLine:=IsEmptyLine and ((StartingInvoicedValue = 0) and (StartingInvoicedQty = 0));
      if ShowExpected then IsEmptyLine:=IsEmptyLine and ((StartingExpectedValue = 0) and (StartingExpectedQty = 0));
    end;
    ValueEntry.SetRange("Posting Date", StartDate, EndDate);
    ValueEntry.SetFilter("Item Ledger Entry Type", '%1|%2|%3|%4', ValueEntry."Item Ledger Entry Type"::Purchase, ValueEntry."Item Ledger Entry Type"::"Positive Adjmt.", ValueEntry."Item Ledger Entry Type"::Output, ValueEntry."Item Ledger Entry Type"::"Assembly Output");
    ValueEntry.CalcSums("Item Ledger Entry Quantity", "Cost Amount (Actual)", "Cost Amount (Expected)", "Invoiced Quantity");
    AssignAmounts(ValueEntry, IncreaseInvoicedValue, IncreaseInvoicedQty, IncreaseExpectedValue, IncreaseExpectedQty, 1);
    ValueEntry.SetRange("Posting Date", StartDate, EndDate);
    ValueEntry.SetFilter("Item Ledger Entry Type", '%1|%2|%3|%4', ValueEntry."Item Ledger Entry Type"::Sale, ValueEntry."Item Ledger Entry Type"::"Negative Adjmt.", ValueEntry."Item Ledger Entry Type"::Consumption, ValueEntry."Item Ledger Entry Type"::"Assembly Consumption");
    ValueEntry.CalcSums("Item Ledger Entry Quantity", "Cost Amount (Actual)", "Cost Amount (Expected)", "Invoiced Quantity");
    AssignAmounts(ValueEntry, DecreaseInvoicedValue, DecreaseInvoicedQty, DecreaseExpectedValue, DecreaseExpectedQty, -1);
    ValueEntry.SetRange("Posting Date", StartDate, EndDate);
    ValueEntry.SetRange("Item Ledger Entry Type", ValueEntry."Item Ledger Entry Type"::Transfer);
    if ValueEntry.FindSet then repeat if true in[ValueEntry."Valued Quantity" < 0, not GetOutboundItemEntry(ValueEntry."Item Ledger Entry No.")]then AssignAmounts(ValueEntry, DecreaseInvoicedValue, DecreaseInvoicedQty, DecreaseExpectedValue, DecreaseExpectedQty, -1)
        else
          AssignAmounts(ValueEntry, IncreaseInvoicedValue, IncreaseInvoicedQty, IncreaseExpectedValue, IncreaseExpectedQty, 1);
      until ValueEntry.Next() = 0;
    IsEmptyLine:=IsEmptyLine and ((IncreaseInvoicedValue = 0) and (IncreaseInvoicedQty = 0));
    IsEmptyLine:=IsEmptyLine and ((DecreaseInvoicedValue = 0) and (DecreaseInvoicedQty = 0));
    if ShowExpected then begin
      IsEmptyLine:=IsEmptyLine and ((IncreaseExpectedValue = 0) and (IncreaseExpectedQty = 0));
      IsEmptyLine:=IsEmptyLine and ((DecreaseExpectedValue = 0) and (DecreaseExpectedQty = 0));
    end;
    ValueEntry.SetRange("Posting Date", 0D, EndDate);
    ValueEntry.SetRange("Item Ledger Entry Type");
    ValueEntry.CalcSums("Cost Posted to G/L", "Expected Cost Posted to G/L");
    ExpCostPostedToGL+=ValueEntry."Expected Cost Posted to G/L";
    InvCostPostedToGL+=ValueEntry."Cost Posted to G/L";
    StartingExpectedValue+=StartingInvoicedValue;
    IncreaseExpectedValue+=IncreaseInvoicedValue;
    DecreaseExpectedValue+=DecreaseInvoicedValue;
    CostPostedToGL:=ExpCostPostedToGL + InvCostPostedToGL;
    IsHandled:=false;
    if not IsHandled then if IsEmptyLine then CurrReport.Skip();
    if StartingInvoicedQty <> 0 then AvgStartprice:=StartingExpectedValue / StartingInvoicedQty;
    Amount:=StartingExpectedValue;
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
        group(Options)
        {
          Caption = 'Options';

          field(StartingDate;StartDate)
          {
            ApplicationArea = Basic, Suite;
            Caption = 'Starting Date';
            ToolTip = 'Specifies the date from which the report or batch job processes information.';
          }
          field(EndingDate;EndDate)
          {
            ApplicationArea = Basic, Suite;
            Caption = 'Ending Date';
            ToolTip = 'Specifies the date to which the report or batch job processes information.';
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
  trigger OnPreReport()begin
    if(StartDate = 0D) and (EndDate = 0D)then EndDate:=WorkDate;
    if StartDate in[0D, 00000101D]then StartDateText:=''
    else
      StartDateText:=Format(StartDate - 1);
    ItemFilter:=Item.GetFilters();
  end;
  var documentNo: Code[50];
  itemavgAmount: Decimal;
  avgamount: Decimal;
  Amount: Decimal;
  vendor: Record Vendor;
  //item: Record item;
  Compyinformation: Record "Company Information";
  CalAmount: Decimal;
  CalAmount2: Decimal;
  PurchasePrice: Decimal;
  Quantity2: Decimal;
  showDeteil: Boolean;
  location: Record Location;
  TypeTxt: text[10];
  ValueEntry: Record "Value Entry";
  Text005: Label 'As of %1';
  StartDate: Date;
  EndDate: Date;
  ShowExpected: Boolean;
  ItemFilter: Text;
  StartDateText: Text[10];
  StartingInvoicedValue: Decimal;
  StartingExpectedValue: Decimal;
  StartingInvoicedQty: Decimal;
  StartingExpectedQty: Decimal;
  IncreaseInvoicedValue: Decimal;
  IncreaseExpectedValue: Decimal;
  IncreaseInvoicedQty: Decimal;
  IncreaseExpectedQty: Decimal;
  DecreaseInvoicedValue: Decimal;
  DecreaseExpectedValue: Decimal;
  DecreaseInvoicedQty: Decimal;
  DecreaseExpectedQty: Decimal;
  BoM_TextLbl: Label 'Base UoM';
  Inventory_ValuationCaptionLbl: Label 'Inventory Valuation';
  CurrReport_PAGENOCaptionLbl: Label 'Page';
  This_report_includes_entries_that_have_been_posted_with_expected_costs_CaptionLbl: Label 'This report includes entries that have been posted with expected costs.';
  IncreaseInvoicedQtyCaptionLbl: Label 'Increases (LCY)';
  DecreaseInvoicedQtyCaptionLbl: Label 'Decreases (LCY)';
  QuantityCaptionLbl: Label 'Quantity';
  ValueCaptionLbl: Label 'Value';
  QuantityCaption_Control31Lbl: Label 'Quantity';
  QuantityCaption_Control40Lbl: Label 'Quantity';
  InvCostPostedToGL_Control53CaptionLbl: Label 'Cost Posted to G/L';
  QuantityCaption_Control58Lbl: Label 'Quantity';
  TotalCaptionLbl: Label 'Total';
  Expected_Cost_Included_TotalCaptionLbl: Label 'Expected Cost Included Total';
  Expected_Cost_TotalCaptionLbl: Label 'Expected Cost Total';
  Expected_Cost_IncludedCaptionLbl: Label 'Expected Cost Included';
  InvCostPostedToGL: Decimal;
  CostPostedToGL: Decimal;
  ExpCostPostedToGL: Decimal;
  IsEmptyLine: Boolean;
  AvgStartprice: Decimal;
  local procedure AssignAmounts(ValueEntry: Record "Value Entry";
  var InvoicedValue: Decimal;
  var InvoicedQty: Decimal;
  var ExpectedValue: Decimal;
  var ExpectedQty: Decimal;
  Sign: Decimal)begin
    InvoicedValue+=ValueEntry."Cost Amount (Actual)" * Sign;
    InvoicedQty+=ValueEntry."Invoiced Quantity" * Sign;
    ExpectedValue+=ValueEntry."Cost Amount (Expected)" * Sign;
    ExpectedQty+=ValueEntry."Item Ledger Entry Quantity" * Sign;
  end;
  local procedure GetOutboundItemEntry(ItemLedgerEntryNo: Integer): Boolean var ItemApplnEntry: Record "Item Application Entry";
  ItemLedgEntry: Record "Item Ledger Entry";
  begin
    ItemApplnEntry.SetCurrentKey("Item Ledger Entry No.");
    ItemApplnEntry.SetRange("Item Ledger Entry No.", ItemLedgerEntryNo);
    if not ItemApplnEntry.FindFirst then exit(true);
    ItemLedgEntry.SetRange("Item No.", Item."No.");
    ItemLedgEntry.SetFilter("Variant Code", Item.GetFilter("Variant Filter"));
    ItemLedgEntry.SetFilter("Location Code", Item.GetFilter("Location Filter"));
    ItemLedgEntry.SetFilter("Global Dimension 1 Code", Item.GetFilter("Global Dimension 1 Filter"));
    ItemLedgEntry.SetFilter("Global Dimension 2 Code", Item.GetFilter("Global Dimension 2 Filter"));
    ItemLedgEntry."Entry No.":=ItemApplnEntry."Outbound Item Entry No.";
    exit(not ItemLedgEntry.Find);
  end;
}
