report 50140 "RMT_Summary Rec By Vendor"
{
  Caption = 'Summary Receiving By Vendor';
  UsageCategory = Administration;
  ApplicationArea = All;
  DefaultLayout = RDLC;
  RDLCLayout = 'Report/Layout/SummaryReceivingByVendor.rdl';

  dataset
  {
  dataitem("Purchase Header";
  "Purchase Header")
  {
  RequestFilterFields = "Document date", "Posting Date";
  DataItemTableView = sorting("Document Date")WHERE("Status"=const(Released), "Document Type"=const(Order));

  //CalcFields = "Cost Amount (Actual)", "Cost Amount (Expected)";\
  column(Entry_No_;
  "No.")
  {
  }
  column(Source_No_;
  "Buy-from Vendor No.")
  {
  }
  column(Source_Type;
  "Document Type")
  {
  }
  column(vendorName;
  vendor.Name)
  {
  }
  column(CalAmountIncVat;
  CalAmountIncVat)
  {
  }
  column(cVat;
  cVat)
  {
  }
  //column(Description; Description) { }
  //column(Unit_of_Measure_Code; "Unit of Measure Code") { }
  //column(Cost_Amount__Expected_; "Cost Amount (Expected)") { }
  //column(Quantity; Quantity) { }
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
  column(Location_Code;
  location.Name)
  {
  }
  column(locationName;
  location.Name)
  {
  }
  trigger OnAfterGetRecord()var purchaseLine: Record "Purchase Line";
  begin
    Compyinformation.get;
    Compyinformation.CalcFields(Picture);
    vendor.reset;
    if not vendor.get("Buy-from Vendor No.")then vendor.init;
    // item.reset;
    // if not item.get("Item No.") then
    //     item.Init();
    // Clear(CalAmount);
    // if "Cost Amount (Actual)" <> 0 then
    //     CalAmount := ABS(Quantity) * ABS("Cost Amount (Actual)")
    // else
    //     CalAmount := ABS(Quantity) * ABS("Cost Amount (Expected)");
    CalAmount:=0;
    CalAmountIncVat:=0;
    cVat:=0;
    // if "Completely Received" = false then begin
    //     purchaseLine.reset;
    //     purchaseLine.SetRange("Document Type", "Document Type");
    //     purchaseLine.SetRange("document No.", "No.");
    //     if purchaseLine.Find('-') then begin
    //         repeat
    //             CalAmount += purchaseLine."Quantity Received" * purchaseLine."Direct Unit Cost";
    //             if purchaseLine."VAT %" <> 0 then
    //                 cVat += CalAmount * purchaseLine."VAT %" / 100;
    //         until purchaseLine.next() = 0;
    //         // if purchaseLine."VAT %" <> 0 then
    //         //     cVat := CalAmount * purchaseLine."VAT %" / 100;
    //         // CalAmountIncVat := cVat + CalAmount;
    //         CalAmountIncVat := CalAmount;
    //     end;
    //     location.reset;
    //     if not location.get("Location Code") then
    //         location.init;
    // end else begin
    CalcFields(Amount, "Amount Including VAT");
    if "Purchase Header"."Prices Including VAT" then begin
      CalAmount:=amount; //"Amount Including VAT";
      CalAmountIncVat:=amount; //"Amount Including VAT";
    end
    else
    begin
      CalAmount:=Amount;
      CalAmountIncVat:=Amount;
    end;
    if not location.get("Location Code")then location.init;
  //CalAmountIncVat := "Amount Including VAT";
  //cVat := CalAmountIncVat - CalAmountIncVat;
  //end;
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
        // Caption = 'Option';
        // field(showDeteil; showDeteil)
        // {
        //     Caption = 'Show Deteil';
        //     ApplicationArea = All;
        // }
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
  CalAmountIncVat: Decimal;
  cVat: Decimal;
  location: Record Location;
  showDeteil: Boolean;
}
